package atelier.elements;

import haxe.ds.BalancedTree.TreeNode;
import kha.graphics2.Graphics;
import dreamengine.plugins.dreamui.Element;

class TreeView extends Element {
	var model:TreeNode;

	var totalHeight:Float = 0;

	public function setModel(model:TreeNode) {
		this.model = model;
	}

    function renderNode(g:Graphics, tree:TreeNode, depth:Int){
        var pos = getRect().getPosition();
        var size = getRect().getSize();
        for(i in 0...tree.children.length){
            var cur = tree.children[i];
            g.drawRect(10 + pos.x + depth * 10, pos.y + totalHeight, size.x, 20);
			g.drawString(cur.value, 10 + pos.x + depth * 10, pos.y + totalHeight);
			totalHeight += 20;
        }
    }

	function renderTree(g:Graphics, tree:TreeNode, depth:Int = 0) {
        renderNode(g, tree, depth);
		for (i in 0...tree.children.length) {
			var node = tree.children[i];
            renderTree(g, node, depth + 1);
		}
	}

	override function onRender(g2:Graphics, opacity:Float) {
		renderTree(g2, model, 0);
		totalHeight = 0;
	}
}

class TreeNode {
	public var value:String;

	public function new(value:String) {
		this.value = value;
	}

	public var children:Array<TreeNode> = [];
}
