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
// **The import at the top IS the first assertion.** `slate:dom` exists everywhere and refuses
// everywhere, because a refusal at the import is a complaint about the module and sends a reader
// looking for a spelling mistake in the one line that is right; this package keeps that rule by
// declaring one external, `globalThis`, whose path every host has. If that were `external document`
// instead, this file would not compile and no test in it would run -- which is exactly the failure
// these tests are here to notice.
//
// Each body below is one call wrapped in `assertFaults`, checking the sentence names the host rather
// than the value:
//
//     assertFaults(() -> createElement("div"), "no JavaScript host")
//
// and the three at the end are about the surface rather than about any one name.

@test
createElement_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
createText_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
createComment_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
setAttribute_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
removeAttribute_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
setProperty_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
setChildren_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
setText_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
insertBefore_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
removeChild_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
splitText_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
release_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
byId_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
query_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
children_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
tagName_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
nodeText_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
attribute_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
nodeKind_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
property_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
markup_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
on_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
off_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
dispatch_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
observe_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
events_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
focus_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
blur_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
activeElement_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
location_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
pushPath_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
replacePath_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
back_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
forward_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
onNavigate_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
stored_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
store_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
unstore_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
storedKeys_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
clearStored_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
cookies_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
cookie_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
setCookie_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
deleteCookie_FAULTS_WHERE_THERE_IS_NO_JAVASCRIPT_HOST()
    skip("the body is not written yet")

@test
THE_MODULE_IMPORTS_WHERE_THERE_IS_NO_DOCUMENT_AT_ALL()
    skip("the body is not written yet")

@test
EVERY_NAME_THE_MODULE_EXPORTS_IS_A_FUNCTION()
    skip("the body is not written yet")

@test
THE_EXPORT_LIST_IS_THE_ONE_slate_dom_HAS_NAME_FOR_NAME()
    skip("the body is not written yet")

@test
A_REFUSAL_NAMES_THE_HOST_AND_NOT_THE_HANDLE_TABLE_THAT_IS_NO_LONGER_THERE()
    skip("the body is not written yet")
