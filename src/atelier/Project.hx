package atelier;

import haxe.ds.Option;
using StringTools;


class Project {
    var configPath:String;
    var path: String;

    function new(){
    }

    public function getPath(){
        return path;
    }

    public static function loadFromPath(path:String): Option<Project>{
        if (!path.endsWith("dreamgame.json")){
            return None;
        }
        #if sys
        var exists = sys.FileSystem.exists(path);
        if (!exists) return None;
        #end
        var pr = new Project();
        pr.configPath = path;
        pr.path = path.split("dreamgame.json")[0];
        return Some(pr);
    }
}