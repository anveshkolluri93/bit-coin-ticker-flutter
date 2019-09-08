import 'networking.dart';

const url = 'https://apiv2.bitcoinaverage.com';

class BitcoinApi {
  final String currency;

  BitcoinApi(this.currency);

  Future getCurrencyValue() async {
    NetworkHelper networkHelper =
        NetworkHelper('$url/indices/global/ticker/BTC$currency');

    print('$url/indices/global/ticker/BTC$currency');
    var bitcoinPriceInfo = await networkHelper.getData();
    return bitcoinPriceInfo;
  }
}
