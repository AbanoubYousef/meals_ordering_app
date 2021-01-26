import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
 final Function savefilter;
final Map<String,bool> currentfilters;
  FiltersScreen(this.currentfilters,this. savefilter);
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegan = false;
  bool _vegetarian = false;
  @override
  initState(){
    _glutenFree=widget.currentfilters['gluten'];
    _vegetarian=widget.currentfilters['vegetarian'];
    _lactoseFree=widget.currentfilters['lactose'];
    _vegetarian=widget.currentfilters['vegan'];
    super.initState();
  }

  Widget _buildSwitchListTile(
      String title, bool value, String subtitle, Function onchange) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      subtitle: Text(subtitle),
      onChanged: onchange,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save),onPressed:(){
            final selectedFilter= {
              'gloten':_glutenFree ,
              'lactose':_lactoseFree,
              'vegetarian':_vegetarian,
              'vegan':_vegan
            };
            widget.savefilter(selectedFilter);
          },),
            ],
            ),
            drawer: MainDrawer(),
            body: Column(
            children: <Widget>[
            Container(
            padding: EdgeInsets.all(20),
            child: Text(
            'Adjust your meal selection.',
            style: Theme.of(context).textTheme.title,
            ),
            ),
            Expanded(
            child: ListView(
            children: <Widget>[
            _buildSwitchListTile(
            "Gluten-free", _glutenFree, 'Only include gluten-free meal',
            (newval) {
            setState(() {
            _glutenFree = newval;
            });
            }
          ),
              _buildSwitchListTile(
                  "Lactose-free", _lactoseFree, 'Only include lactose-free meal',
                      (newval) {
                    setState(() {
                      _lactoseFree = newval;
                    });
                  }),
              _buildSwitchListTile(
                  "Vegetarian", _vegetarian, 'Only include Vegetarian meal',
                      (newval) {
                    setState(() {
                      _vegetarian = newval;
                    });
                  }),
              _buildSwitchListTile(
                  "Vegan", _vegan, 'Only include Vegan meal',
                      (newval) {
                    setState(() {
                      _vegan = newval;
                    });
                  }),
            ],
          ))
        ],
      ),
    );
  }
}
