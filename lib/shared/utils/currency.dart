import 'package:intl/intl.dart';

class Currency {
  String formatMoney({
    required double value,
    required String currency,
  }) {
    return NumberFormat.currency(
      locale: 'pt_br',
      name: currency,
      symbol: _getCurrencySymbol(currency),
    ).format(value);
  }

  List<AllCurrencies> getAllCurrencies() {
    return [
      AllCurrencies(code: 'BRL', name: 'Real brasileiro', symbol: 'R\$'),
      AllCurrencies(code: 'AED', name: 'Dirham dos Emirados Árabes Unidos', symbol: 'د.إ'),
      AllCurrencies(code: 'AFN', name: 'Afegane afegão', symbol: '؋'),
      AllCurrencies(code: 'ALL', name: 'Lek albanês', symbol: 'Lek'),
      AllCurrencies(code: 'AMD', name: 'Dram armênio', symbol: '֏'),
      AllCurrencies(code: 'ANG', name: 'Florim das Antilhas Holandesas', symbol: 'ƒ'),
      AllCurrencies(code: 'AOA', name: 'Kwanza angolano', symbol: 'Kz'),
      AllCurrencies(code: 'ARS', name: 'Peso argentino', symbol: '\$'),
      AllCurrencies(code: 'AUD', name: 'Dólar australiano', symbol: 'A\$'),
      AllCurrencies(code: 'AWG', name: 'Florim de Aruba', symbol: 'ƒ'),
      AllCurrencies(code: 'AZN', name: 'Manat azeri', symbol: '₼'),
      AllCurrencies(code: 'BAM', name: 'Marco conversível da Bósnia e Herzegovina', symbol: 'КМ'),
      AllCurrencies(code: 'BBD', name: 'Dólar barbadiano', symbol: '\$'),
      AllCurrencies(code: 'BDT', name: 'Taka de Bangladesh', symbol: '৳'),
      AllCurrencies(code: 'BGN', name: 'Lev búlgaro', symbol: 'лв'),
      AllCurrencies(code: 'BHD', name: 'Dinar bareinita', symbol: 'ب.د'),
      AllCurrencies(code: 'BIF', name: 'Franco burundiano', symbol: 'FBu'),
      AllCurrencies(code: 'BMD', name: 'Dólar bermudiano', symbol: '\$'),
      AllCurrencies(code: 'BND', name: 'Dólar do Brunei', symbol: '\$'),
      AllCurrencies(code: 'BOB', name: 'Boliviano boliviano', symbol: 'Bs'),
      AllCurrencies(code: 'BSD', name: 'Dólar bahamense', symbol: '\$'),
      AllCurrencies(code: 'BTN', name: 'Ngultrum butanês', symbol: 'Nu.'),
      AllCurrencies(code: 'BWP', name: 'Pula de Botswana', symbol: 'P'),
      AllCurrencies(code: 'BYN', name: 'Rublo bielorrusso', symbol: 'Br'),
      AllCurrencies(code: 'BZD', name: 'Dólar do Belize', symbol: 'BZ\$'),
      AllCurrencies(code: 'CAD', name: 'Dólar canadense', symbol: 'CA\$'),
      AllCurrencies(code: 'CDF', name: 'Franco congolês', symbol: 'FC'),
      AllCurrencies(code: 'CHF', name: 'Franco suíço', symbol: 'CHF'),
      AllCurrencies(code: 'CLP', name: 'Peso chileno', symbol: '\$'),
      AllCurrencies(code: 'CNY', name: 'Yuan chinês', symbol: '¥'),
      AllCurrencies(code: 'COP', name: 'Peso colombiano', symbol: '\$'),
      AllCurrencies(code: 'CRC', name: 'Colón costa-riquenho', symbol: '₡'),
      AllCurrencies(code: 'CUP', name: 'Peso cubano', symbol: '\$'),
      AllCurrencies(code: 'CVE', name: 'Escudo cabo-verdiano', symbol: 'Esc'),
      AllCurrencies(code: 'CZK', name: 'Coroa checa', symbol: 'Kč'),
      AllCurrencies(code: 'DJF', name: 'Franco do Djibuti', symbol: 'Fdj'),
      AllCurrencies(code: 'DKK', name: 'Coroa dinamarquesa', symbol: 'kr'),
      AllCurrencies(code: 'DOP', name: 'Peso dominicano', symbol: 'RD\$'),
      AllCurrencies(code: 'DZD', name: 'Dinar argelino', symbol: 'د.ج'),
      AllCurrencies(code: 'EGP', name: 'Libra egípcia', symbol: 'E£'),
      AllCurrencies(code: 'ERN', name: 'Nakfa eritreia', symbol: 'Nfk'),
      AllCurrencies(code: 'ETB', name: 'Birr etíope', symbol: 'Br'),
      AllCurrencies(code: 'EUR', name: 'Euro', symbol: '€'),
      AllCurrencies(code: 'FJD', name: 'Dólar de Fiji', symbol: '\$'),
      AllCurrencies(code: 'FKP', name: 'Libra das Ilhas Falkland', symbol: '£'),
      AllCurrencies(code: 'FOK', name: 'Coroa das Ilhas Feroé', symbol: 'kr'),
      AllCurrencies(code: 'GBP', name: 'Libra esterlina', symbol: '£'),
      AllCurrencies(code: 'GEL', name: 'Lari georgiano', symbol: '₾'),
      AllCurrencies(code: 'GGP', name: 'Libra de Guernsey', symbol: '£'),
      AllCurrencies(code: 'GHS', name: 'Cedi ganês', symbol: '₵'),
      AllCurrencies(code: 'GIP', name: 'Libra de Gibraltar', symbol: '£'),
      AllCurrencies(code: 'GMD', name: 'Dalasi gambiano', symbol: 'D'),
      AllCurrencies(code: 'GNF', name: 'Franco guineense', symbol: 'FG'),
      AllCurrencies(code: 'GTQ', name: 'Quetzal guatemalteco', symbol: 'Q'),
      AllCurrencies(code: 'GYD', name: 'Dólar guianense', symbol: '\$'),
      AllCurrencies(code: 'HKD', name: 'Dólar de Hong Kong', symbol: 'HK\$'),
      AllCurrencies(code: 'HNL', name: 'Lempira hondurenha', symbol: 'L'),
      AllCurrencies(code: 'HRK', name: 'Kuna croata', symbol: 'kn'),
      AllCurrencies(code: 'HTG', name: 'Gourde haitiana', symbol: 'G'),
      AllCurrencies(code: 'HUF', name: 'Forint húngaro', symbol: 'Ft'),
      AllCurrencies(code: 'IDR', name: 'Rupia indonésia', symbol: 'Rp'),
      AllCurrencies(code: 'ILS', name: 'Novo shekel israelense', symbol: '₪'),
      AllCurrencies(code: 'IMP', name: 'Libra de Man', symbol: '£'),
      AllCurrencies(code: 'INR', name: 'Rúpia indiana', symbol: '₹'),
      AllCurrencies(code: 'IQD', name: 'Dinar iraquiano', symbol: 'ع.د'),
      AllCurrencies(code: 'IRR', name: 'Rial iraniano', symbol: '﷼'),
      AllCurrencies(code: 'ISK', name: 'Coroa islandesa', symbol: 'kr'),
      AllCurrencies(code: 'JEP', name: 'Libra de Jersey', symbol: '£'),
      AllCurrencies(code: 'JMD', name: 'Dólar jamaicano', symbol: 'J\$'),
      AllCurrencies(code: 'JOD', name: 'Dinar jordaniano', symbol: 'د.ا'),
      AllCurrencies(code: 'JPY', name: 'Iene japonês', symbol: '¥'),
      AllCurrencies(code: 'KES', name: 'Xelim queniano', symbol: 'KSh'),
      AllCurrencies(code: 'KGS', name: 'Som quirguiz', symbol: 'сом'),
      AllCurrencies(code: 'KHR', name: 'Riel cambojano', symbol: '៛'),
      AllCurrencies(code: 'KID', name: 'Dólar das Ilhas Cayman', symbol: '\$'),
      AllCurrencies(code: 'KMF', name: 'Franco comoriano', symbol: 'CF'),
      AllCurrencies(code: 'KPW', name: 'Won norte-coreano', symbol: '₩'),
      AllCurrencies(code: 'KRW', name: 'Won sul-coreano', symbol: '₩'),
      AllCurrencies(code: 'KWD', name: 'Dinar kuwaitiano', symbol: 'د.ك'),
      AllCurrencies(code: 'KYD', name: 'Dólar das Ilhas Caiman', symbol: '\$'),
      AllCurrencies(code: 'KZT', name: 'Tenge cazaque', symbol: '₸'),
      AllCurrencies(code: 'LAK', name: 'Kip laosiano', symbol: '₭'),
      AllCurrencies(code: 'LBP', name: 'Libra libanesa', symbol: 'ل.ل'),
      AllCurrencies(code: 'LKR', name: 'Rupia do Sri Lanka', symbol: 'රු'),
      AllCurrencies(code: 'LRD', name: 'Dólar liberiano', symbol: '\$'),
      AllCurrencies(code: 'LSL', name: 'Loti do Lesoto', symbol: 'L'),
      AllCurrencies(code: 'LYD', name: 'Dinar líbio', symbol: 'ل.د'),
      AllCurrencies(code: 'MAD', name: 'Dirham marroquino', symbol: 'د.م.'),
      AllCurrencies(code: 'MDL', name: 'Leu moldávio', symbol: 'lei'),
      AllCurrencies(code: 'MGA', name: 'Ariary malgaxe', symbol: 'Ar'),
      AllCurrencies(code: 'MKD', name: 'Denar macedônio', symbol: 'ден'),
      AllCurrencies(code: 'MMK', name: 'Quiate birmanês', symbol: 'K'),
      AllCurrencies(code: 'MNT', name: 'Tugrik mongol', symbol: '₮'),
      AllCurrencies(code: 'MOP', name: 'Pataca de Macau', symbol: 'MOP\$'),
      AllCurrencies(code: 'MRU', name: 'Uquiya mauritana', symbol: 'UM'),
      AllCurrencies(code: 'MUR', name: 'Rupia mauriciana', symbol: '₨'),
      AllCurrencies(code: 'MVR', name: 'Rupia de Maldivas', symbol: 'ރ.'),
      AllCurrencies(code: 'MWK', name: 'Kwacha malawiana', symbol: 'MK'),
      AllCurrencies(code: 'MXN', name: 'Peso mexicano', symbol: '\$'),
      AllCurrencies(code: 'MYR', name: 'Ringgit malaio', symbol: 'RM'),
      AllCurrencies(code: 'MZN', name: 'Metical moçambicano', symbol: 'MT'),
      AllCurrencies(code: 'NAD', name: 'Dólar namibiano', symbol: '\$'),
      AllCurrencies(code: 'NGN', name: 'Naira nigeriana', symbol: '₦'),
      AllCurrencies(code: 'NIO', name: 'Córdoba nicaraguense', symbol: 'C\$'),
      AllCurrencies(code: 'NOK', name: 'Coroa norueguesa', symbol: 'kr'),
      AllCurrencies(code: 'NPR', name: 'Rupia nepalesa', symbol: '₨'),
      AllCurrencies(code: 'NZD', name: 'Dólar da Nova Zelândia', symbol: 'NZ\$'),
      AllCurrencies(code: 'OMR', name: 'Rial omanense', symbol: 'ر.ع.'),
      AllCurrencies(code: 'PAB', name: 'Balboa do Panamá', symbol: 'B/.'),
      AllCurrencies(code: 'PEN', name: 'Sol peruano', symbol: 'S/.'),
      AllCurrencies(code: 'PGK', name: 'Kina papuásia', symbol: 'K'),
      AllCurrencies(code: 'PHP', name: 'Peso filipino', symbol: '₱'),
      AllCurrencies(code: 'PKR', name: 'Rupia paquistanesa', symbol: '₨'),
      AllCurrencies(code: 'PLN', name: 'Zloty polonês', symbol: 'zł'),
      AllCurrencies(code: 'PYG', name: 'Guarani paraguaio', symbol: '₲'),
      AllCurrencies(code: 'QAR', name: 'Rial catariano', symbol: 'ر.ق'),
      AllCurrencies(code: 'RON', name: 'Leu romeno', symbol: 'lei'),
      AllCurrencies(code: 'RSD', name: 'Dinar sérvio', symbol: 'дин.'),
      AllCurrencies(code: 'RUB', name: 'Rublo russo', symbol: '₽'),
      AllCurrencies(code: 'RWF', name: 'Franco ruandês', symbol: 'FRw'),
      AllCurrencies(code: 'SAR', name: 'Rial saudita', symbol: 'ر.س'),
      AllCurrencies(code: 'SBD', name: 'Dólar das Ilhas Salomão', symbol: '\$'),
      AllCurrencies(code: 'SCR', name: 'Rupia das Seychelles', symbol: '₨'),
      AllCurrencies(code: 'SDG', name: 'Libra sudanesa', symbol: '£'),
      AllCurrencies(code: 'SEK', name: 'Coroa sueca', symbol: 'kr'),
      AllCurrencies(code: 'SGD', name: 'Dólar de Singapura', symbol: '\$'),
      AllCurrencies(code: 'SHP', name: 'Libra de Santa Helena', symbol: '£'),
      AllCurrencies(code: 'SLL', name: 'Leone de Serra Leoa', symbol: 'Le'),
      AllCurrencies(code: 'SOS', name: 'Xelim somali', symbol: 'Sh'),
      AllCurrencies(code: 'SRD', name: 'Dólar do Suriname', symbol: '\$'),
      AllCurrencies(code: 'SSP', name: 'Libra sul-sudanesa', symbol: '£'),
      AllCurrencies(code: 'STN', name: 'Dobra de São Tomé e Príncipe', symbol: 'Db'),
      AllCurrencies(code: 'SYP', name: 'Libra síria', symbol: 'ل.س'),
      AllCurrencies(code: 'SZL', name: 'Lilangeni da Suazilândia', symbol: 'L'),
      AllCurrencies(code: 'THB', name: 'Baht tailandês', symbol: '฿'),
      AllCurrencies(code: 'TJS', name: 'Somoni tajique', symbol: 'SM'),
      AllCurrencies(code: 'TMT', name: 'Manat turcomeno', symbol: 'T'),
      AllCurrencies(code: 'TND', name: 'Dinar tunisino', symbol: 'د.ت'),
      AllCurrencies(code: 'TOP', name: 'Paʻanga tonganesa', symbol: 'T\$'),
      AllCurrencies(code: 'TRY', name: 'Lira turca', symbol: '₺'),
      AllCurrencies(code: 'TTD', name: 'Dólar de Trindade e Tobago', symbol: 'TT\$'),
      AllCurrencies(code: 'TVD', name: 'Dólar de Tuvalu', symbol: '\$'),
      AllCurrencies(code: 'TWD', name: 'Novo dólar taiwanês', symbol: 'NT\$'),
      AllCurrencies(code: 'TZS', name: 'Xelim tanzaniano', symbol: 'TSh'),
      AllCurrencies(code: 'UAH', name: 'Hryvnia ucraniano', symbol: '₴'),
      AllCurrencies(code: 'UGX', name: 'Xelim ugandense', symbol: 'USh'),
      AllCurrencies(code: 'USD', name: 'Dólar dos Estados Unidos', symbol: 'US\$'),
      AllCurrencies(code: 'UYU', name: 'Peso uruguaio', symbol: '\$U'),
      AllCurrencies(code: 'UZS', name: 'Som uzbeque', symbol: 'сўм'),
      AllCurrencies(code: 'VES', name: 'Bolívar venezuelano', symbol: 'Bs'),
      AllCurrencies(code: 'VND', name: 'Dong vietnamita', symbol: '₫'),
      AllCurrencies(code: 'VUV', name: 'Vatu de Vanuatu', symbol: 'VT'),
      AllCurrencies(code: 'WST', name: 'Tala samoano', symbol: 'WS\$'),
      AllCurrencies(code: 'XAF', name: 'Franco CFA da África Central', symbol: 'FCFA'),
      AllCurrencies(code: 'XCD', name: 'Dólar do Caribe Oriental', symbol: 'EC\$'),
      AllCurrencies(code: 'XDR', name: 'Direitos Especiais de Giro', symbol: 'SDR'),
      AllCurrencies(code: 'XOF', name: 'Franco CFA da África Ocidental', symbol: 'CFA'),
      AllCurrencies(code: 'XPF', name: 'Franco CFP', symbol: 'CFP'),
      AllCurrencies(code: 'YER', name: 'Rial iemenita', symbol: '﷼'),
      AllCurrencies(code: 'ZAR', name: 'Rand sul-africano', symbol: 'R'),
      AllCurrencies(code: 'ZMW', name: 'Kwacha zambiano', symbol: 'ZK'),
      AllCurrencies(code: 'ZWL', name: 'Dólar do Zimbábue', symbol: 'Z\$')
    ];
  }

  String _getCurrencySymbol(String currencyCode) {
    switch (currencyCode.toUpperCase()) {
      case 'AED':
        return 'د.إ';
      case 'AFN':
        return '؋';
      case 'ALL':
        return 'Lek';
      case 'AMD':
        return '֏';
      case 'ANG':
        return 'ƒ';
      case 'AOA':
        return 'Kz';
      case 'ARS':
        return '\$';
      case 'AUD':
        return 'A\$';
      case 'AWG':
        return 'ƒ';
      case 'AZN':
        return '₼';
      case 'BAM':
        return 'КМ';
      case 'BBD':
        return '\$';
      case 'BDT':
        return '৳';
      case 'BGN':
        return 'лв';
      case 'BHD':
        return 'ب.د';
      case 'BIF':
        return 'FBu';
      case 'BMD':
        return '\$';
      case 'BND':
        return '\$';
      case 'BOB':
        return 'Bs';
      case 'BRL':
        return 'R\$';
      case 'BSD':
        return '\$';
      case 'BTN':
        return 'Nu.';
      case 'BWP':
        return 'P';
      case 'BYN':
        return 'Br';
      case 'BZD':
        return 'BZ\$';
      case 'CAD':
        return 'CA\$';
      case 'CDF':
        return 'FC';
      case 'CHF':
        return 'CHF';
      case 'CLP':
        return '\$';
      case 'CNY':
        return '¥';
      case 'COP':
        return '\$';
      case 'CRC':
        return '₡';
      case 'CUP':
        return '\$';
      case 'CVE':
        return 'Esc';
      case 'CZK':
        return 'Kč';
      case 'DJF':
        return 'Fdj';
      case 'DKK':
        return 'kr';
      case 'DOP':
        return 'RD\$';
      case 'DZD':
        return 'د.ج';
      case 'EGP':
        return 'E£';
      case 'ERN':
        return 'Nfk';
      case 'ETB':
        return 'Br';
      case 'EUR':
        return '€';
      case 'FJD':
        return '\$';
      case 'FKP':
        return '£';
      case 'FOK':
        return 'kr';
      case 'GBP':
        return '£';
      case 'GEL':
        return '₾';
      case 'GGP':
        return '£';
      case 'GHS':
        return '₵';
      case 'GIP':
        return '£';
      case 'GMD':
        return 'D';
      case 'GNF':
        return 'FG';
      case 'GTQ':
        return 'Q';
      case 'GYD':
        return '\$';
      case 'HKD':
        return 'HK\$';
      case 'HNL':
        return 'L';
      case 'HRK':
        return 'kn';
      case 'HTG':
        return 'G';
      case 'HUF':
        return 'Ft';
      case 'IDR':
        return 'Rp';
      case 'ILS':
        return '₪';
      case 'IMP':
        return '£';
      case 'INR':
        return '₹';
      case 'IQD':
        return 'ع.د';
      case 'IRR':
        return '﷼';
      case 'ISK':
        return 'kr';
      case 'JEP':
        return '£';
      case 'JMD':
        return 'J\$';
      case 'JOD':
        return 'د.ا';
      case 'JPY':
        return '¥';
      case 'KES':
        return 'KSh';
      case 'KGS':
        return 'сом';
      case 'KHR':
        return '៛';
      case 'KID':
        return '\$';
      case 'KMF':
        return 'CF';
      case 'KPW':
        return '₩';
      case 'KRW':
        return '₩';
      case 'KWD':
        return 'د.ك';
      case 'KYD':
        return '\$';
      case 'KZT':
        return '₸';
      case 'LAK':
        return '₭';
      case 'LBP':
        return 'ل.ل';
      case 'LKR':
        return 'රු';
      case 'LRD':
        return '\$';
      case 'LSL':
        return 'L';
      case 'LYD':
        return 'ل.د';
      case 'MAD':
        return 'د.م.';
      case 'MDL':
        return 'lei';
      case 'MGA':
        return 'Ar';
      case 'MKD':
        return 'ден';
      case 'MMK':
        return 'K';
      case 'MNT':
        return '₮';
      case 'MOP':
        return 'MOP\$';
      case 'MRU':
        return 'UM';
      case 'MUR':
        return '₨';
      case 'MVR':
        return 'ރ.';
      case 'MWK':
        return 'MK';
      case 'MXN':
        return '\$';
      case 'MYR':
        return 'RM';
      case 'MZN':
        return 'MT';
      case 'NAD':
        return '\$';
      case 'NGN':
        return '₦';
      case 'NIO':
        return 'C\$';
      case 'NOK':
        return 'kr';
      case 'NPR':
        return '₨';
      case 'NZD':
        return 'NZ\$';
      case 'OMR':
        return 'ر.ع.';
      case 'PAB':
        return 'B/.';
      case 'PEN':
        return 'S/.';
      case 'PGK':
        return 'K';
      case 'PHP':
        return '₱';
      case 'PKR':
        return '₨';
      case 'PLN':
        return 'zł';
      case 'PYG':
        return '₲';
      case 'QAR':
        return 'ر.ق';
      case 'RON':
        return 'lei';
      case 'RSD':
        return 'дин.';
      case 'RUB':
        return '₽';
      case 'RWF':
        return 'FRw';
      case 'SAR':
        return 'ر.س';
      case 'SBD':
        return '\$';
      case 'SCR':
        return '₨';
      case 'SDG':
        return '£';
      case 'SEK':
        return 'kr';
      case 'SGD':
        return '\$';
      case 'SHP':
        return '£';
      case 'SLL':
        return 'Le';
      case 'SOS':
        return 'Sh';
      case 'SRD':
        return '\$';
      case 'SSP':
        return '£';
      case 'STN':
        return 'Db';
      case 'SYP':
        return 'ل.س';
      case 'SZL':
        return 'L';
      case 'THB':
        return '฿';
      case 'TJS':
        return 'SM';
      case 'TMT':
        return 'T';
      case 'TND':
        return 'د.ت';
      case 'TOP':
        return 'T\$';
      case 'TRY':
        return '₺';
      case 'TTD':
        return 'TT\$';
      case 'TVD':
        return '\$';
      case 'TWD':
        return 'NT\$';
      case 'TZS':
        return 'TSh';
      case 'UAH':
        return '₴';
      case 'UGX':
        return 'USh';
      case 'USD':
        return 'US\$';
      case 'UYU':
        return '\$U';
      case 'UZS':
        return 'сўм';
      case 'VES':
        return 'Bs';
      case 'VND':
        return '₫';
      case 'VUV':
        return 'VT';
      case 'WST':
        return 'WS\$';
      case 'XAF':
        return 'FCFA';
      case 'XCD':
        return 'EC\$';
      case 'XDR':
        return 'SDR';
      case 'XOF':
        return 'CFA';
      case 'XPF':
        return 'CFP';
      case 'YER':
        return '﷼';
      case 'ZAR':
        return 'R';
      case 'ZMW':
        return 'ZK';
      case 'ZWL':
        return 'Z\$';
      default:
        return '';
    }
  }
}

class AllCurrencies {
  final String code;
  final String name;
  final String symbol;
  AllCurrencies({
    required this.code,
    required this.name,
    required this.symbol,
  });
}
