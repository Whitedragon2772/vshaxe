package;

typedef Project = {
    /** name of a target in defaults.json to base all targets in this config on **/
    @:optional var inherit(default,null):String;
    var haxelibs(default,null):Array<Haxelib>;
    var targets(default,null):Array<Target>;
}

typedef Haxelib = {
    var name(default,null):String;
    var installArgs(default,null):Array<String>;
}

typedef Target = {
    >TargetArguments,
    /** Whether this target is just a collection of other targets **/
    @:optional var composite(default,null):Bool;
    /** name of a target in defaults.json to base this config on **/
    @:optional var inherit(default,null):String;
    /** name of the target - must be unique! **/
    var name(default,null):String;
    /** arguments that only apply in debug mode **/
    @:optional var debugArgs(default,null):TargetArguments;
    /** arguments that only apply for display **/
    @:optional var displayArgs(default,null):TargetArguments;

    /** VSCode tasks.json config **/
    @:optional var isBuildCommand(default,null):Bool;
    @:optional var isTestCommand(default,null):Bool;
}

typedef TargetArguments = {
    >Hxml,
    @:optional var targetDependencies(default,null):Array<String>;
    /** additional, non-haxelib install commands (npm install...) **/
    @:optional var installCommands(default,null):Array<Array<String>>;
    @:optional var beforeBuildCommands(default,null):Array<Array<String>>;
    @:optional var afterBuildCommands(default,null):Array<Array<String>>;
}

typedef Hxml = {
    @:optional var workingDirectory(default,null):String;
    @:optional var classPaths(default,null):Array<String>;
    @:optional var defines(default,null):Array<String>;
    @:optional var haxelibs(default,null):Array<String>;
    @:optional var debug(default,null):Bool;
    @:optional var output(default,null):Output;
    @:optional var deadCodeElimination(default,null):String; // TODO enum abstract
    @:optional var noInline(default,null):Bool;
    @:optional var main(default,null):String; // can only specify either main or package, but you could specify both here :/
    @:optional var packageName(default,null):String;
}

typedef Output = {
    var target(default,null):String; // TODO enum abstract
    var path(default,null):String;
}

// https://github.com/elnabo/json2object/issues/9
/*@:forward(iterator)
abstract ArrayHandle<T>(Array<T>) from Array<T> {
    public function get() {
        return if (this == null) [] else this.copy();
    }
}*/