{
    name: "dom",
    version: "0.2.0",

    // The whole surface, and the same forty-four names `slate:dom` exports. A consumer changes one
    // import line and nothing else.
    //
    // **slate 0.0.40 is the floor.** `external` arrived in 0.0.38 and is the whole reason this
    // package can exist, every function below being built on it; an external hashing by the host
    // value it holds arrived in 0.0.39, and the listener table is keyed by the node. 0.0.40 fixed
    // `assertFaults` panicking under the interpreter and a dotted write's wrong wording, both of
    // which this package's own tests ran into. A manifest has no key for a compiler floor -- the
    // reader takes `name`, `version`, `main`, `modules`, `dependencies` and `devDependencies` and
    // names anything else -- so the floor is stated in the README and here, and a program built on
    // an older compiler fails at the first `external` with a parse error rather than a version
    // complaint.
    main: "dom.slx",
}
