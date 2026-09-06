{
    name: "dom",
    version: "0.1.0",

    // The whole surface, and the same forty-four names `slate:dom` exports. A consumer changes one
    // import line and nothing else.
    //
    // **slate 0.0.39 is the floor.** `external` arrived in 0.0.38 and is the whole reason this
    // package can exist, every function below being built on it; an external hashing by the host
    // value it holds arrived in 0.0.39, and the listener table is keyed by the node. A manifest has
    // no key for that -- the reader takes `name`, `version`, `main`, `modules`, `dependencies` and
    // `devDependencies` and names anything else -- so the floor is stated in the README and here,
    // and a program built on an older compiler fails at the first `external` with a parse error
    // rather than a version complaint.
    main: "dom.slx",
}
