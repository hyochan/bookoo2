import 'package:bookoox/models/Currency.dart';
import 'package:flutter/material.dart';

import '../utils/localization.dart' show Localization;
import '../shared/header.dart' show renderHeaderBack;
import '../shared/setting_list_item.dart' show ListItem, TileItem, SettingTileItem;

class SettingCurrency extends StatefulWidget {
  SettingCurrency({
    Key key,
    this.title = '',
    this.selectedCurrency = '',
  }) : super(key: key);
  final String title;
  final String selectedCurrency;

  @override
  _SettingCurrencyState createState() => _SettingCurrencyState();
}

class _SettingCurrencyState extends State<SettingCurrency> {
  void onSettingCurrency(Currency selectedCurrency) {
    print('on setting currency ${selectedCurrency.toString()}');
    Navigator.pop(context, selectedCurrency);
  }

  @override
  Widget build(BuildContext context) {
    var _localization = Localization.of(context);

    final List<ListItem> _items = currencies.map((el) => TileItem(
        title: '${el.currency} | ${el.symbol}',
        trailing: el.currency == widget.selectedCurrency ? Icon(Icons.check) : Text(''),
        onTap: () => onSettingCurrency(Currency(
          locale: el.locale,
          currency: el.currency,
          symbol: el.symbol,
        )),
      )
    ).toList();

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: renderHeaderBack(
        centerTitle: false,
        context: context,
        iconColor: Theme.of(context).iconTheme.color,
        brightness: Theme.of(context).brightness,
        title: Text(
          _localization.trans('CURRENCY'),
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).textTheme.headline1.color,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
                separatorBuilder: (context, index) => Divider(
                  color: Colors.grey,
                  height: 1,
                ),
                itemCount : _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return SettingTileItem(item);
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
