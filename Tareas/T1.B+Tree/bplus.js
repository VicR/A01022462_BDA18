var Node = {
  constructor: function(order) {
    this.order = order;
    this.isNode = true;
    this.isInternalNode = false;
    this.parentNode = null;
    this.nextNode = null;
    this.prevNode = null;
    this.data = [0];
  },
  //separar
  splitNode: function(){
    var tmp = Node;
    tmp.constructor(this.order);
    var m = Math.ceil(this.data.length / 2);
    var k = this.data[m-1].key;

    for(var i = 0; i < m; i++) {
      tmp.data[i] = this.data.shift();
    }

    tmp.parentNode = this.parentNode;
    tmp.nextNode = this;
    tmp.prevNode = this.prevNode;

    if (tmp.prevNode) tmp.prevNode.nextNode = tmp;
    this.prevNode = tmp;

    if (!this.parentNode) {
      var p = InternalNode;
      p.constructor(this.order);
      this.parentNode = tmp.parentNode = p;
    }

    return this.parentNode.insert(k, tmp, this);
  },

  insert: function(key, value){
    var pos = 0;

    for(; pos < this.data.length; pos++) {
      if (this.data[pos].key == key) {
        this.data[pos].value = value;
        return null;
      }

      if (this.data[pos].key > key) break;
    }

    if (this.data[pos]) this.data.splice(pos, 0, {"key": key, "value": value});
    else this.data.push({"key": key, "value": value});

    // splitNode
    if (this.data.length > this.order) return this.splitNode();
    return null;
  }
};

var InternalNode = {

  constructor: function(order) {
    this.order = order;
    this.isNode = false;
    this.isInternalNode = true;
    this.parentNode = null;
    this.data = [];
  },

  splitNode: function() {
    var m = null;

    if (this.order % 2){
      var m = (this.data.length-1) / 2 - 1;
    } else {
      var m = (this.data.length-1) / 2;
    }

    var tmp = new InternalNode(this.order);
    tmp.parentNode = this.parentNode;

    for(var i = 0; i < m; i++) {
      tmp.data[i] = this.data.shift();
    }

    for(var i = 0; i < tmp.data.length; i += 2) {
      tmp.data[i].parentNode = tmp;
    }

    var key = this.data.shift();

    if (!this.parentNode){
      this.parentNode = tmp.parentNode = new InternalNode(this.order);
    }

    return this.parentNode.insert(key, tmp, this);
  },

  insert: function(key, node1, node2) {
    if (this.data.length){
      var pos = 1;

      for(; pos < this.data.length; pos += 2) {
        if (this.data[pos] > key) break;
      }

      if (this.data[pos]) {
        pos--;
        this.data.splice(pos, 0, key);
        this.data.splice(pos, 0, node1);
      } else {
        this.data[pos-1] = node1;
        this.data.push(key);
        this.data.push(node2);
      }

      if (this.data.length > (this.order * 2 + 1)) {
        return this.splitNode();
      }

      return null;
    } else {
      this.data[0] = node1;
      this.data[1] = key;
      this.data[2] = node2;

      return this;
    }
  }
};

var BPlusTree = {

  options: {
    order: 2
  },

  constructor: function(options) {
    this.root = Node;
    this.root.constructor(this.options.order);
  },

  add: function(key, value) {
    var node = this._search(key);
    var ret = node.insert(key, value);
    if (ret) this.root = ret;
  },

  _search: function(key) {
    var current = this.root;
    var found = false;

    while(current.isInternalNode) {
      found = false;
      var len = current.data.length;

      for(var i = 1; i < len; i += 2) {
        if (key <= current.data[i]) {
          current = current.data[i-1];
          found = true;
          break;
        }
      }

      if (!found) current = current.data[len - 1];
    }

    return current;
  },

  walk: function(node, level, arr) {
    var current = node;

    if (!arr[level]) arr[level] = [];

    if (current.isNode){
      for(var i = 0; i < current.data.length; i++) {
        arr[level].push("<" + current.data[i].key + ">");
      }
      arr[level].push(" -> ");
    } else {
      for(var i = 1; i < node.data.length; i += 2) {
        arr[level].push("<" + node.data[i] + ">");
      }

      arr[level].push(" -> ");

      for(var i = 0; i < node.data.length; i += 2) {
        this.walk(node.data[i], level + 1, arr);
      }
    }

    return arr;
  },
};

var bptree = BPlusTree;
bptree.constructor({order: 100});
const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var index = 0;
  var recursiveReadline = function(){rl.question('Inserte valores de bptree, escriba n para salir ', (answer) => {

    if(answer == "n" || answer == ""){
      console.log(bptree);
      rl.close();
    }
    else {
      bptree.add("key" + index, answer)
      console.log(`Valor ${answer} insertado`);
      index ++;
      recursiveReadline();
    }
  });
};

recursiveReadline();
