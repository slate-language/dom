import { createElement, createText, createComment, setAttribute, removeAttribute, setProperty,
    setChildren, setText, insertBefore, removeChild, splitText, release } from "../dom.slx"
import { byId, query, children, tagName, nodeText, attribute, nodeKind, property,
    markup } from "../dom.slx"
import { on, off, dispatch, observe, events, focus, blur, activeElement } from "../dom.slx"
import { location, pushPath, replacePath, back, forward, onNavigate } from "../dom.slx"
import { stored, store, unstore, storedKeys, clearStored } from "../dom.slx"
import { cookies, cookie, setCookie, deleteCookie } from "../dom.slx"

// The string host: every name, refused, and the module still importing.
//
// **This suite is the one that says the refusals are refusals.** There is no document here and no
// JavaScript host at all, so nothing below can check what a name DOES -- what it checks is that the
// module loads, that every name is there, and that calling one raises rather than answering
// something plausible. `tests-dom/dom.slx` is where behaviour is measured, against a real page.
//
// **The import at the top IS the first assertion.** This module imports everywhere and refuses
// only when a name is called, because a refusal at the import is a complaint about the module and
// sends a reader looking for a spelling mistake in the one line that is right. The package keeps
// that rule by declaring one external, `globalThis`, whose path every host has. If that were
// `external document` instead, this file would not compile and no test in it would run -- which is
// exactly the failure these tests are here to notice.
//
// Each body below is one call whose refusal is read and asked what it says, the sentence naming the
// host rather than the value:
//
//     refused(() -> createElement("div"), refusal)
//
// and the four at the end are about the surface rather than about any one name.
//
// **The file runs on two hosts and the sentence is not the same on both.** The interpreter refuses in
// the language's own words -- there is no JavaScript host at all -- and a JavaScript host with no page
// refuses in this module's, naming the document, the window, the store or the `EventSource` it has
// not got. `refusal` is that difference in one place, and the sixteen names that want a node are the
// interpreter's alone.

import * as ours from "../dom.slx"

external globalThis

// A stand-in for a node. **On a host with no JavaScript there is nothing else an external can be**:
// the declaration is accepted everywhere, and the first thing done to the value it bound is what
// refuses. So handing this to a name that wants a node is what makes the refusal below the one this
// file is measuring.
val node = globalThis

// **What a refusal SAYS is not one sentence, because this file runs on two hosts that lack a page
// for different reasons.** The interpreter refuses in the language's own words, naming the host
// operation; a JavaScript host with no document refuses in this module's, naming what it has not got.
val refusal = if host() == "interpreter" then "the interpreter has no JavaScript host"
    else "this JavaScript host has none"

// **The names that take a NODE are the interpreter's alone.** A JavaScript host with no page answers
// an ordinary property read on the global object rather than refusing it, so there is nothing there
// that reads as a node -- and a name given one would be measuring the global object instead of the
// refusal. The names that reach the document, the window or the store first are measured on both.
needsNode()
    if host() != "interpreter"
        skip("a node cannot be stood in for on a host that answers property reads")

// What a call said when it faulted, read through `catch` for the one test below that asks more of
// the sentence than "does it contain this part".
saidBy(f) = ran(f) catch e -> e.message

ran(f)
    f()

    "nothing was refused"

// One refusal: the call has to fault, and the sentence has to contain the part given.
refused(f, expected)
    assertFaults(f, expected)

@test
createElement_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    refused(() -> createElement("div"), refusal)

@test
createText_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    refused(() -> createText("said"), refusal)

@test
createComment_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    refused(() -> createComment("mark"), refusal)

@test
setAttribute_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    needsNode()

    refused(() -> setAttribute(node, "class", "row"), refusal)

@test
removeAttribute_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    needsNode()

    refused(() -> removeAttribute(node, "class"), refusal)

@test
setProperty_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    needsNode()

    refused(() -> setProperty(node, "value", "typed"), refusal)

@test
setChildren_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    needsNode()

    refused(() -> setChildren(node, []), refusal)

@test
setText_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    needsNode()

    refused(() -> setText(node, "said"), refusal)

@test
insertBefore_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    needsNode()

    refused(() -> insertBefore(node, node, null), refusal)

@test
removeChild_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    needsNode()

    refused(() -> removeChild(node, node), refusal)

@test
splitText_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    needsNode()

    refused(() -> splitText(node, 1), refusal)

@test
release_IS_A_NO_OP_AND_REACHES_NO_HOST_AT_ALL()
    // **There is no handle table here and therefore nothing to give back**, so `release` is a no-op
    // that touches no host -- which is why it answers rather than refusing where every other name
    // refuses. A consumer written against the built-in module calls it and nothing happens.
    assertEq(release(node), null)
    assertEq(release(null), null)

@test
byId_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    refused(() -> byId("app"), refusal)

@test
query_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    refused(() -> query("#app"), refusal)

@test
children_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    needsNode()

    refused(() -> children(node), refusal)

@test
tagName_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    needsNode()

    refused(() -> tagName(node), refusal)

@test
nodeText_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    needsNode()

    refused(() -> nodeText(node), refusal)

@test
attribute_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    needsNode()

    refused(() -> attribute(node, "class"), refusal)

@test
nodeKind_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    needsNode()

    refused(() -> nodeKind(node), refusal)

@test
property_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    needsNode()

    refused(() -> property(node, "value"), refusal)

@test
markup_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    needsNode()

    refused(() -> markup(node), refusal)

@test
on_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    needsNode()

    refused(() -> on(node, "click", ran), refusal)

@test
off_IS_A_NO_OP_FOR_A_LISTENER_THAT_WAS_NEVER_INSTALLED()
    // `off` reaches the host only to abort a listener this module installed, and on a host with no
    // page there is none -- so it answers, exactly as taking off a listener that was never added
    // does in a browser.
    assertEq(off(node, "click", ran), null)

@test
dispatch_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    refused(() -> dispatch(node, "click"), refusal)

@test
observe_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    refused(() -> observe(node, { children: true }, ran), refusal)

@test
events_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    refused(() -> events("/updates"), refusal)

@test
focus_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    refused(() -> focus(node), refusal)

@test
blur_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    refused(() -> blur(node), refusal)

@test
activeElement_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    refused(() -> activeElement(), refusal)

@test
location_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    refused(() -> location(), refusal)

@test
pushPath_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    refused(() -> pushPath("/notes/7"), refusal)

@test
replacePath_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    refused(() -> replacePath("/notes/7"), refusal)

@test
back_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    refused(() -> back(), refusal)

@test
forward_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    refused(() -> forward(), refusal)

@test
onNavigate_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    refused(() -> onNavigate(ran), refusal)

@test
stored_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    refused(() -> stored("theme"), refusal)

@test
store_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    refused(() -> store("theme", "dark"), refusal)

@test
unstore_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    refused(() -> unstore("theme"), refusal)

@test
storedKeys_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    refused(() -> storedKeys(), refusal)

@test
clearStored_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    refused(() -> clearStored(), refusal)

@test
cookies_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    refused(() -> cookies(), refusal)

@test
cookie_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    refused(() -> cookie("theme"), refusal)

@test
setCookie_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    refused(() -> setCookie("theme", "dark"), refusal)

@test
deleteCookie_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    refused(() -> deleteCookie("theme"), refusal)

@test
THE_MODULE_IMPORTS_WHERE_THERE_IS_NO_DOCUMENT_AT_ALL()
    // **The import is the first assertion in this file**, and it has already happened by the time
    // this runs: one `external globalThis`, whose path every host has, with every other host value
    // read inside the function that wants it. An `external document` at the top of the module would
    // take the whole file with it here and no test in it would run.
    assert(host() != "browser", "this suite runs where there is no page")
    assertEq(keys(ours).length, 44)
    assert(ours.byId is function, "a name is bound and it is the module's own")

@test
EVERY_NAME_THE_MODULE_EXPORTS_IS_A_FUNCTION()
    for name in keys(ours)
        assert(ours[name] is function, name + " is a function")

@test
THE_EXPORT_LIST_IS_THE_ONE_slate_dom_HAD_NAME_FOR_NAME()
    // **A consumer migrated by changing one import line**, which was only true while the two lists
    // were the same list. The built-in is gone from slate, so the list is written down here: it is
    // the forty-four names `docs/library/dom.md` in the slate repository specifies, and a name added
    // or dropped is a change to what every consumer imports.
    val specified = ["activeElement", "attribute", "back", "blur", "byId", "children", "clearStored",
        "cookie", "cookies", "createComment", "createElement", "createText", "deleteCookie",
        "dispatch", "events", "focus", "forward", "insertBefore", "location", "markup", "nodeKind",
        "nodeText", "observe", "off", "on", "onNavigate", "property", "pushPath", "query", "release",
        "removeAttribute", "removeChild", "replacePath", "setAttribute", "setChildren", "setCookie",
        "setProperty", "setText", "splitText", "store", "stored", "storedKeys", "tagName", "unstore"]

    assertEq(keys(ours).sorted(), specified)

@test
A_REFUSAL_NAMES_THE_HOST_AND_NOT_THE_HANDLE_TABLE_THAT_IS_NO_LONGER_THERE()
    refused(() -> byId("app"), refusal)

    // The built-in module hands out an index into a table and says so when one is stale. There is no
    // table here, so no refusal may send a reader looking for one.
    val said = saidBy(() -> byId("app"))

    assert(!contains(said, "released"), said)
    assert(!contains(said, "handle"), said)
