// A document, for the half of this package that has one.
//
//     npm install
//     NODE_OPTIONS="--import ./tests-dom/setup.mjs" slate test --js tests-dom
//
// **`slate test --js` writes the whole suite into one file and runs `node` on it**, so there is
// nowhere to put a `<script>` and no page to load. `--import` is the seam: node runs this module
// before the program, and the program reads the host off `globalThis` -- so a document that is there
// by then is the document the suite renders into.
//
// **THE ORDER IS WHAT MAKES IT WORK, AND IT IS NOT AN ACCIDENT OF TIMING.** `--import` runs this to
// completion before the first line of the emitted program, and the package declares exactly one
// external -- `globalThis`, which every host has -- and reads everything else off it inside the
// function that wants it. So there is no window in which a name could be looked for and not found:
// the declaration touches no host at all, and every read happens inside a test that runs after this
// file has installed the page.
//
// **jsdom rather than a fake document written beside the code it checks, and that is the point.** A
// shim written here would agree with `dom.slx` by construction: every mistake this package could
// make about what `setAttribute`, `replaceChildren` or `addEventListener` do, the shim would make
// too, and the run would pass. jsdom is somebody else's reading of the same specification and is
// free to disagree.
//
// **`AbortController` is installed from the WINDOW and not left to node's own.** It is how `off`
// takes a listener back -- `addEventListener(kind, f, { signal })` and `abort()` -- and a signal
// built in one realm handed to an element in another is a foreign object to the interface that
// checks it. A page has one realm and never meets this; a harness has two.
//
// **jsdom has no `EventSource`**, so `events` is the one name this suite cannot measure against a
// real implementation. It is left absent rather than stubbed: the package answers a sentence naming
// what the host has not, and that sentence is what the suite checks.

let JSDOM
let VirtualConsole

try {
    const jsdom = await import("jsdom")

    JSDOM = jsdom.JSDOM
    VirtualConsole = jsdom.VirtualConsole
} catch (e) {
    console.error("jsdom is not installed: run npm install")
    process.exit(1)
}

let navigations = 0

// **jsdom's own console, intercepted rather than silenced.** A navigation it will not perform is
// something a test may want to count, so it is counted here and kept off the terminal; anything else
// jsdom has to say is passed straight through, because a real error swallowed by a harness is how a
// suite goes quietly green.
const console_ = new VirtualConsole()

console_.on("jsdomError", (e) => {
    const said = String(e && e.message ? e.message : e)

    if (said.includes("Not implemented: navigation")) {
        navigations += 1

        return
    }

    console.error(said)
})

for (const kind of ["log", "info", "warn", "error", "dir", "table", "trace"])
    console_.on(kind, (...parts) => console[kind === "dir" ? "log" : kind](...parts))

const dom = new JSDOM(
    "<!doctype html><html><head></head><body><div id=\"page\"></div></body></html>",
    { url: "https://example.test/", virtualConsole: console_ })

const w = dom.window
const doc = w.document

// The names the package reads off `globalThis`. **`addEventListener` has to be the WINDOW's**: node's
// global is an `EventTarget` of its own, so leaving it alone would register `popstate` on something
// the page never raises one on.
const install = (name, value) => {
    try {
        Object.defineProperty(globalThis, name,
            { value: value, writable: true, configurable: true, enumerable: true })
    } catch (e) {
        globalThis[name] = value
    }
}

install("window", w)
install("document", doc)
install("location", w.location)
install("history", w.history)
install("localStorage", w.localStorage)
install("Node", w.Node)
install("Element", w.Element)
install("HTMLElement", w.HTMLElement)
install("MutationObserver", w.MutationObserver)
install("MouseEvent", w.MouseEvent)
install("KeyboardEvent", w.KeyboardEvent)
install("Event", w.Event)
install("AbortController", w.AbortController)
install("AbortSignal", w.AbortSignal)
install("addEventListener", w.addEventListener.bind(w))
install("removeEventListener", w.removeEventListener.bind(w))
install("dispatchEvent", w.dispatchEvent.bind(w))
