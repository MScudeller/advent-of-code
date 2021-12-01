import "package:collection/collection.dart";

import '../Day.dart';

class Day08 extends Day {
  String _input;
  var width = 25;
  var height = 6;
  Map<int, List<int>> layers;

  Day08(List<String> stringInput) {
    _input = stringInput.first;
    _input.length;
    var pixelQuantity = width * height;
    var foo =
        _input.runes.map((r) => int.parse(String.fromCharCode(r))).toList();

    layers = Map<int, List<int>>();
    for (var i = 0; i < foo.length; i++) {
      var layer = i ~/ pixelQuantity;
      var element = foo[i];
      var list = layers.putIfAbsent(layer, () => []);
      list.add(element);
    }
  }

  @override
  part1() {
    var layersByZero =
        layers.map((k, v) => MapEntry(k, v.where((e) => e == 0).length));
    var layerKey =
        layersByZero.entries.reduce((a, b) => a.value < b.value ? a : b).key;
    var layer = layers[layerKey].toList()..sort();
    var group = groupBy(layer, (e) => e);

    return group[1].length * group[2].length;
  }

  @override
  part2() {
    var finalLayer = [for (var i = 0; i < height * width; i++) 2];
    for (var layer in layers.values) {
      for (var i = 0; i < finalLayer.length; i++) {
        finalLayer[i] = finalLayer[i] == 2 ? layer[i] : finalLayer[i];
      }
    }

    printLayer(finalLayer);
  }

  printLayer(List<int> layer) {
    var chars = {0:'\u2588', 1:'\u2591',2:'\u2593'};

    for (var i = 0; i < height; i++) {
      var line = layer.skip(i*width).take(width);
      var lineString = line.map((e) => chars[e]).join();
      print(lineString);
    }
  }
}
