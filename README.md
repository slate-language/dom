# dom

The document, as a package — the same surface [`slate:dom`](https://slatelang.dev/library/dom/) has,
written in [slate](https://github.com/slate-language/slate) on top of `external`.

```
slate add github.com/slate-language/dom
```

```slate
import { byId, setText, on } from dom
```

**Forty-four names, and a consumer migrates by changing one import line.** `slate:dom` is thirteen
hand-written builtins in the compiler's JavaScript back end, and while they lived there every name a
page wanted cost a language release: `focus`, `blur` and `activeElement` waited for 0.0.37 and
`dispatch` and `observe` waited again. `external` — slate 0.0.38 — is the door the compiler grew so
that this could be ordinary slate. A name added here ships the moment this package does.

```slate
import { byId, setText, on } from slate:dom     // before
import { byId, setText, on } from dom           // after
```

## The decisions

**A node IS the external.** The element itself, not an index into a table the engine keeps. That is
a reversal of what the built-in module chose, and `external` is what makes it safe: an external is
opaque, it cannot be printed as anything but `<external HTMLDivElement>`, it cannot be added to or
iterated, and it matches no pattern but a bare name — so a host object reaching a program is already
the thing the handle table was protecting the program from. `==` on two nodes is identity, which is
what the integer handle promised and what `external` promises directly.

**`release` is exported and does nothing.** There is no handle table and therefore nothing to give
back; the element stays exactly where it is in the page, which is what `release` always did. It stays
on the export list so that a consumer written against the built-in module — lath calls it in two
places — compiles and runs unchanged.

**An event arrives as a record of eight fields, built here.** `{ type, value, checked, key, mods,
button, stop, prevent }`, where `mods` is `{ meta, ctrl, shift, alt }` and `button` is an integer or
`null`. Handing the host's event over as an external would put a value in a program's hands that it
could not print, compare or store, and would make every handler in every consumer read host
properties instead of slate fields. `mods` and `button` are there because a link cannot be written
without them: a framework that intercepts a click has to let a cmd-click, a ctrl-click, a shift-click
and a middle click through to the browser.

**`off` needs the same JavaScript function `on` handed over, and slate cannot name it**, so the
package keeps its own map. A slate closure crosses outward as a *fresh* JavaScript function every
time it crosses, so the value `removeEventListener` would be given is never the value
`addEventListener` was given. The map is keyed by the slate closure itself — slate compares a
function by identity, the rule it states for a set, a map, a promise and a function alike — and what
it holds is an `AbortController`, whose signal `on` passes to `addEventListener` and whose `abort()`
is what `off` calls. That is the DOM's own way of removing a listener without naming the function
again.

**Everything is reached through one declaration, `globalThis`.** A declaration is eager and total:
the path is walked where it stands, and one that names nothing is a fault quoting it — so
`external document` at the top of the file would take the whole module with it on a host that has no
document, which is exactly where a server-rendering framework imports this and then guards its calls
with `host()`. `slate:dom`'s rule is that the module still exists and the import still succeeds,
because a refusal at the import is a complaint about the module and sends a reader looking for a
spelling mistake in the one line that is right. A property read off `globalThis` answers `null` for a
name that is not there, which is what keeps that rule true here — and it is what keeps the
interpreter's rule true as well, the declaration itself touching no host.

**Navigation goes through `window.history` and a `popstate` listener.** `location()` is a record read
off the window; `pushPath` and `replacePath` are `pushState` and `replaceState`; `back` and `forward`
are the history's own. A push does *not* raise `onNavigate`, which is the browser's rule — the event
is for a movement the user made — so a router renders after its own push and waits to be told about
everything else. Getting that wrong is how a router renders twice. There is no state object: the url
is the whole of the state.

**Under the interpreter every declaration succeeds and only a host operation faults.** The package
needs no special casing for it and has none.

## The names

Every one is `slate:dom`'s, spelled the same and taking the same arguments. Where the meaning
differs, it says so.

| | |
|---|---|
| `createElement(tag)`, `createText(s)`, `createComment(s)` | |
| `setAttribute`, `removeAttribute`, `setProperty` | |
| `on(node, event, fn)`, `off(node, event, fn)` | **`off` takes the function, not an id** — which is what the built-in does and what its own page's table gets wrong |
| `setChildren(node, kids)`, `setText(node, s)` | |
| `insertBefore(parent, node, before)` | one child, in front of another; `null` appends |
| `removeChild(parent, node)` | one child, out |
| `byId(id)`, `query(selector)` | |
| `children(node)` | the child nodes, in order — every one, not only the elements |
| `tagName(node)` | the tag in lower case, or `null` for a text node |
| `nodeText(node)` | what the node says, as text |
| `attribute(node, name)` | one attribute, or `null`; `true` for a bare one |
| `nodeKind(node)` | `"element"`, `"text"`, `"comment"`, `"fragment"`, `"document"` or `"other"` |
| `property(node, name)` | what the node HOLDS, or `null` |
| `splitText(node, at)` | cut a text node in two, in characters; answers the tail |
| `markup(node)` | the node's outer markup, as a string |
| `release(node)` | **a no-op** — there is no handle to give back |
| `dispatch(node, event)` | send an event; answers whether nothing cancelled it |
| `observe(node, options, fn)` | be told what changed; answers `{ disconnect }` |
| `events(url, options)` | read a server's event stream; answers `{ close }` — **and says which name the host has not**, where it has no `EventSource` |
| `focus(node)`, `blur(node)` | move the caret to a node, and take it away |
| `activeElement()` | the node holding focus, or `null` for nothing (and for the body) |
| `location()` | where the page is, as a record |
| `pushPath(url)`, `replacePath(url)` | move the address bar without a reload |
| `back()`, `forward()` | move through what the page has visited |
| `onNavigate(fn)` | the user moved — **not** a push the program made |
| `stored(key)`, `store(key, v)` | `localStorage`, as results |
| `unstore(key)`, `storedKeys()`, `clearStored()` | |
| `cookies()`, `cookie(name)` | what the document is carrying, as an object or one value |
| `setCookie(name, v, options = {})`, `deleteCookie(name, options = {})` | |

### What a program can see that is different

- **A node prints as `<external HTMLDivElement>`** where the built-in module printed a number.
  Nothing else about a node changes: `==` is identity, it travels through an array, a field and a
  `Map` value like anything else, and `x is external` is the type test.
- **A node is a key**, which every consumer needs: a `Map`, a `Set` and an object settle a key by
  hashing it and then comparing, and an external hashes by the host value it holds rather than by the
  wrapper it crossed in — so two reads of one element are `==`, hash together, and find each other's
  entry. This module keeps a listener's `AbortController` under one, and lath keeps what it last set
  on each node.
- **A node given a listener is held until `off` takes it back.** The built-in module keeps its
  listeners in a `WeakMap` and this one keeps them in an ordinary `Map`, there being no weak map in
  the language — so a page that puts a handler on a node it later drops takes the handler off with
  it. `off` empties every level of the table it leaves empty.
- **The interpreter's refusal names the host operation** — *calling `createElement` on an external
  reaches the JavaScript host, and the interpreter has no JavaScript host* — where the built-in
  module names the slate command. For most of these the host's spelling *is* the command; where it is
  not, `byId` reaching `getElementById`, the reader is still sent to the right place, which is the way
  the program was run.

## The tests

```
slate test tests
slate test --js tests
npm install
NODE_OPTIONS="--import ./tests-dom/setup.mjs" slate test --js tests-dom
```

**The first two are the same suite on two hosts with no page**, and they say the module imports where
there is no document at all, that every name is there, that the export list is `slate:dom`'s name for
name, and that calling one refuses rather than answering something plausible. The interpreter runs all
48; a JavaScript host with no page runs the 32 that reach the document, the window or the store before
they reach a node, and leaves the other 16 out — there being nothing on that host that reads as a node.

**The last is the one that says what the names DO** — 79 tests against a real
[jsdom](https://github.com/jsdom/jsdom) document, `tests-dom/dom.slx` for what a node is and what
happens to one and `tests-dom/doors.slx` for where the page is, where it has been, what it remembers
and what it is carrying. jsdom is a dev dependency of this repository and of nothing else; a program
that uses this package never sees npm.

**Run it with no `NODE_OPTIONS` and it skips rather than fails**, which is the cheap check that the
module still loads on a host with no document — what the one `external globalThis` buys, and what an
`external document` at the top of the file would take away.

**jsdom rather than a fake document written beside the code it checks.** A shim written in the
harness would agree with `dom.slx` by construction: every mistake this package could make about what
`setAttribute`, `replaceChildren` or `addEventListener` do, the shim would make too, and the run
would pass.

## Requirements

slate **0.0.39** or newer, and nothing else. Two things make the floor. `external` itself, which is
what every function here is built on and which arrived in 0.0.38 — an older compiler fails at the
first declaration. And an external hashing by the host value it holds, which arrived in 0.0.39: the
listener table is keyed by the node, so on 0.0.38 `off` would find nothing for a node read a second
time. A manifest has no key for a compiler floor — the reader takes `name`, `version`, `main`,
`modules`, `dependencies` and `devDependencies` and names anything else — so this paragraph is where
it is written down.

## Licence

ISC.
