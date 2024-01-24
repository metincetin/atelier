package atelier;

import haxe.Json;
import sys.io.File;
import sys.FileSystem;
import haxe.ds.Option;
using StringTools;


class Project {
    var configPath:String;
    var path: String;
    var name: String;

    function new(){
    }

    public function getPath(){
        return path;
    }
    public function getName(){
        return name;
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
        var cf = readConfig(path);
        pr.name = cf.gameName;
        return Some(pr);
    }

    static function readConfig(configPath:String){
        var cf = File.getContent(configPath);
        var cfJson = Json.parse(cf);
        return cfJson;
    }

}