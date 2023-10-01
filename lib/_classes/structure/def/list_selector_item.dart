// Copyright 2023 The terCAD team. All rights reserved.
// Use of this source code is governed by a CC BY-NC-ND 4.0 license that can be found in the LICENSE file.

class ListSelectorItem {
  final String id;
  final String name;

  bool match(String search) => name.toLowerCase().contains(search.toLowerCase());

  bool equal(val) => id == val;

  @override
  toString() => name;

  ListSelectorItem({required this.id, required this.name});
}