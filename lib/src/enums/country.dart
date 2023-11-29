/// This class is used to get the country data
/// It staticly contains all the countries in the world with their data
class Country {
  final String name;
  final String alpha2;
  final String alpha3;
  final String flagEmoji;
  final String flagImagePath;
  final int dialCode;
  final int minLength;
  final int maxLength;
  final String mask;

  const Country(
      {required this.name,
      required this.alpha2,
      required this.alpha3,
      required this.flagEmoji,
      required this.flagImagePath,
      required this.dialCode,
      required this.minLength,
      required this.maxLength,
      required this.mask});

  /// Returns the all the countries in the world that are supported by this package
  static const List<Country> values = <Country>[
    Country.afghanistan,
    Country.albania,
    Country.algeria,
    Country.andorra,
    Country.angola,
    Country.antiguaAndBarbuda,
    Country.argentina,
    Country.armenia,
    Country.australia,
    Country.austria,
    Country.azerbaijan,
    Country.bahamas,
    Country.bahrain,
    Country.bangladesh,
    Country.barbados,
    Country.belarus,
    Country.belgium,
    Country.belize,
    Country.benin,
    Country.bhutan,
    Country.bolivia,
    Country.bosniaAndHerzegovina,
    Country.botswana,
    Country.brazil,
    Country.brunei,
    Country.bulgaria,
    Country.burkinaFaso,
    Country.burundi,
    Country.cambodia,
    Country.cameroon,
    Country.canada,
    Country.capeVerde,
    Country.centralAfricanRepublic,
    Country.chad,
    Country.chile,
    Country.china,
    Country.colombia,
    Country.comoros,
    Country.congoDemocraticRepublic,
    Country.congoRepublic,
    Country.costaRica,
    Country.coteDIvoire,
    Country.croatia,
    Country.cuba,
    Country.cyprus,
    Country.czechRepublic,
    Country.denmark,
    Country.djibouti,
    Country.dominica,
    Country.dominicanRepublic,
    Country.eastTimor,
    Country.ecuador,
    Country.egypt,
    Country.elSalvador,
    Country.equatorialGuinea,
    Country.eritrea,
    Country.estonia,
    Country.swaziland,
    Country.ethiopia,
    Country.fiji,
    Country.finland,
    Country.france,
    Country.gabon,
    Country.gambia,
    Country.georgia,
    Country.germany,
    Country.ghana,
    Country.greece,
    Country.grenada,
    Country.guatemala,
    Country.guinea,
    Country.guineaBissau,
    Country.guyana,
    Country.haiti,
    Country.honduras,
    Country.hungary,
    Country.iceland,
    Country.india,
    Country.indonesia,
    Country.iran,
    Country.iraq,
    Country.ireland,
    Country.israel,
    Country.italy,
    Country.jamaica,
    Country.japan,
    Country.jordan,
    Country.kazakhstan,
    Country.kenya,
    Country.kiribati,
    Country.southKorea,
    Country.northKorea,
    Country.kosovo,
    Country.kuwait,
    Country.kyrgyzstan,
    Country.laos,
    Country.latvia,
    Country.lebanon,
    Country.lesotho,
    Country.liberia,
    Country.libya,
    Country.liechtenstein,
    Country.lithuania,
    Country.luxembourg,
    Country.madagascar,
    Country.malawi,
    Country.malaysia,
    Country.maldives,
    Country.mali,
    Country.malta,
    Country.marshallIslands,
    Country.mauritania,
    Country.mauritius,
    Country.mexico,
    Country.micronesia,
    Country.moldova,
    Country.monaco,
    Country.mongolia,
    Country.montenegro,
    Country.morocco,
    Country.mozambique,
    Country.myanmar,
    Country.namibia,
    Country.nauru,
    Country.nepal,
    Country.netherlands,
    Country.newZealand,
    Country.nicaragua,
    Country.niger,
    Country.nigeria,
    Country.norway,
    Country.oman,
    Country.pakistan,
    Country.palau,
    Country.panama,
    Country.papuaNewGuinea,
    Country.paraguay,
    Country.peru,
    Country.philippines,
    Country.poland,
    Country.portugal,
    Country.qatar,
    Country.romania,
    Country.russia,
    Country.rwanda,
    Country.saintKittsAndNevis,
    Country.saintLucia,
    Country.saintVincentAndTheGrenadines,
    Country.samoa,
    Country.sanMarino,
    Country.saoTomeAndPrincipe,
    Country.saudiArabia,
    Country.senegal,
    Country.serbia,
    Country.seychelles,
    Country.sierraLeone,
    Country.singapore,
    Country.slovakia,
    Country.slovenia,
    Country.solomonIslands,
    Country.somalia,
    Country.southAfrica,
    Country.spain,
    Country.sriLanka,
    Country.sudan,
    Country.suriname,
    Country.sweden,
    Country.switzerland,
    Country.syria,
    Country.taiwan,
    Country.tajikistan,
    Country.tanzania,
    Country.thailand,
    Country.togo,
    Country.tonga,
    Country.trinidadAndTobago,
    Country.tunisia,
    Country.turkey,
    Country.turkmenistan,
    Country.tuvalu,
    Country.uganda,
    Country.ukraine,
    Country.unitedArabEmirates,
    Country.unitedKingdom,
    Country.unitedStates,
    Country.uruguay,
    Country.uzbekistan,
    Country.vanuatu,
    Country.vaticanCity,
    Country.venezuela,
    Country.vietnam,
    Country.yemen,
    Country.zambia,
    Country.zimbabwe
  ];

  static const Country afghanistan = Country(
      name: 'Afghanistan',
      alpha2: 'AF',
      alpha3: 'AFG',
      flagEmoji: '🇦🇫',
      flagImagePath: 'assets/flags/af.png',
      dialCode: 93,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country albania = Country(
      name: 'Albania',
      alpha2: 'AL',
      alpha3: 'ALB',
      flagEmoji: '🇦🇱',
      flagImagePath: 'assets/flags/al.png',
      dialCode: 355,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country algeria = Country(
      name: 'Algeria',
      alpha2: 'DZ',
      alpha3: 'DZA',
      flagEmoji: '🇩🇿',
      flagImagePath: 'assets/flags/dz.png',
      dialCode: 213,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country andorra = Country(
      name: 'Andorra',
      alpha2: 'AD',
      alpha3: 'AND',
      flagEmoji: '🇦🇩',
      flagImagePath: 'assets/flags/ad.png',
      dialCode: 376,
      minLength: 6,
      maxLength: 6,
      mask: "### ###");

  static const Country angola = Country(
      name: 'Angola',
      alpha2: 'AO',
      alpha3: 'AGO',
      flagEmoji: '🇦🇴',
      flagImagePath: 'assets/flags/ao.png',
      dialCode: 244,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country antiguaAndBarbuda = Country(
      name: 'Antigua and Barbuda',
      alpha2: 'AG',
      alpha3: 'ATG',
      flagEmoji: '🇦🇬',
      flagImagePath: 'assets/flags/ag.png',
      dialCode: 1,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country argentina = Country(
      name: 'Argentina',
      alpha2: 'AR',
      alpha3: 'ARG',
      flagEmoji: '🇦🇷',
      flagImagePath: 'assets/flags/ar.png',
      dialCode: 54,
      minLength: 10,
      maxLength: 10,
      mask: "## #### ####");

  static const Country armenia = Country(
      name: 'Armenia',
      alpha2: 'AM',
      alpha3: 'ARM',
      flagEmoji: '🇦🇲',
      flagImagePath: 'assets/flags/am.png',
      dialCode: 374,
      minLength: 8,
      maxLength: 8,
      mask: "## ### ###");

  static const Country australia = Country(
      name: 'Australia',
      alpha2: 'AU',
      alpha3: 'AUS',
      flagEmoji: '🇦🇺',
      flagImagePath: 'assets/flags/au.png',
      dialCode: 61,
      minLength: 9,
      maxLength: 9,
      mask: "## #### ####");

  static const Country austria = Country(
      name: 'Austria',
      alpha2: 'AT',
      alpha3: 'AUT',
      flagEmoji: '🇦🇹',
      flagImagePath: 'assets/flags/at.png',
      dialCode: 43,
      minLength: 10,
      maxLength: 10,
      mask: "### ### ### ###");

  static const Country azerbaijan = Country(
      name: 'Azerbaijan',
      alpha2: 'AZ',
      alpha3: 'AZE',
      flagEmoji: '🇦🇿',
      flagImagePath: 'assets/flags/az.png',
      dialCode: 994,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country bahamas = Country(
      name: 'Bahamas',
      alpha2: 'BS',
      alpha3: 'BHS',
      flagEmoji: '🇧🇸',
      flagImagePath: 'assets/flags/bs.png',
      dialCode: 1,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country bahrain = Country(
      name: 'Bahrain',
      alpha2: 'BH',
      alpha3: 'BHR',
      flagEmoji: '🇧🇭',
      flagImagePath: 'assets/flags/bh.png',
      dialCode: 973,
      minLength: 8,
      maxLength: 8,
      mask: "#### ####");

  static const Country bangladesh = Country(
      name: 'Bangladesh',
      alpha2: 'BD',
      alpha3: 'BGD',
      flagEmoji: '🇧🇩',
      flagImagePath: 'assets/flags/bd.png',
      dialCode: 880,
      minLength: 10,
      maxLength: 10,
      mask: "## #### ####");

  static const Country barbados = Country(
      name: 'Barbados',
      alpha2: 'BB',
      alpha3: 'BRB',
      flagEmoji: '🇧🇧',
      flagImagePath: 'assets/flags/bb.png',
      dialCode: 1,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country belarus = Country(
      name: 'Belarus',
      alpha2: 'BY',
      alpha3: 'BLR',
      flagEmoji: '🇧🇾',
      flagImagePath: 'assets/flags/by.png',
      dialCode: 375,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country belgium = Country(
      name: 'Belgium',
      alpha2: 'BE',
      alpha3: 'BEL',
      flagEmoji: '🇧🇪',
      flagImagePath: 'assets/flags/be.png',
      dialCode: 32,
      minLength: 9,
      maxLength: 9,
      mask: "## ### ## ##");

  static const Country belize = Country(
      name: 'Belize',
      alpha2: 'BZ',
      alpha3: 'BLZ',
      flagEmoji: '🇧🇿',
      flagImagePath: 'assets/flags/bz.png',
      dialCode: 501,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country benin = Country(
      name: 'Benin',
      alpha2: 'BJ',
      alpha3: 'BEN',
      flagEmoji: '🇧🇯',
      flagImagePath: 'assets/flags/bj.png',
      dialCode: 229,
      minLength: 8,
      maxLength: 8,
      mask: "## ## ## ##");

  static const Country bhutan = Country(
      name: 'Bhutan',
      alpha2: 'BT',
      alpha3: 'BTN',
      flagEmoji: '🇧🇹',
      flagImagePath: 'assets/flags/bt.png',
      dialCode: 975,
      minLength: 8,
      maxLength: 8,
      mask: "## ### ###");

  static const Country bolivia = Country(
      name: 'Bolivia',
      alpha2: 'BO',
      alpha3: 'BOL',
      flagEmoji: '🇧🇴',
      flagImagePath: 'assets/flags/bo.png',
      dialCode: 591,
      minLength: 8,
      maxLength: 8,
      mask: "### ### ###");

  static const Country bosniaAndHerzegovina = Country(
      name: 'Bosnia and Herzegovina',
      alpha2: 'BA',
      alpha3: 'BIH',
      flagEmoji: '🇧🇦',
      flagImagePath: 'assets/flags/ba.png',
      dialCode: 387,
      minLength: 8,
      maxLength: 8,
      mask: "## ### ###");

  static const Country botswana = Country(
      name: 'Botswana',
      alpha2: 'BW',
      alpha3: 'BWA',
      flagEmoji: '🇧🇼',
      flagImagePath: 'assets/flags/bw.png',
      dialCode: 267,
      minLength: 8,
      maxLength: 8,
      mask: "## ### ###");

  static const Country brazil = Country(
      name: 'Brazil',
      alpha2: 'BR',
      alpha3: 'BRA',
      flagEmoji: '🇧🇷',
      flagImagePath: 'assets/flags/br.png',
      dialCode: 55,
      minLength: 10,
      maxLength: 10,
      mask: "## #### ####");

  static const Country brunei = Country(
      name: 'Brunei',
      alpha2: 'BN',
      alpha3: 'BRN',
      flagEmoji: '🇧🇳',
      flagImagePath: 'assets/flags/bn.png',
      dialCode: 673,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country bulgaria = Country(
      name: 'Bulgaria',
      alpha2: 'BG',
      alpha3: 'BGR',
      flagEmoji: '🇧🇬',
      flagImagePath: 'assets/flags/bg.png',
      dialCode: 359,
      minLength: 8,
      maxLength: 8,
      mask: "### ### ###");

  static const Country burkinaFaso = Country(
      name: 'Burkina Faso',
      alpha2: 'BF',
      alpha3: 'BFA',
      flagEmoji: '🇧🇫',
      flagImagePath: 'assets/flags/bf.png',
      dialCode: 226,
      minLength: 8,
      maxLength: 8,
      mask: "## ## ## ##");

  static const Country burundi = Country(
      name: 'Burundi',
      alpha2: 'BI',
      alpha3: 'BDI',
      flagEmoji: '🇧🇮',
      flagImagePath: 'assets/flags/bi.png',
      dialCode: 257,
      minLength: 8,
      maxLength: 8,
      mask: "## ## ## ##");

  static const Country cambodia = Country(
      name: 'Cambodia',
      alpha2: 'KH',
      alpha3: 'KHM',
      flagEmoji: '🇰🇭',
      flagImagePath: 'assets/flags/kh.png',
      dialCode: 855,
      minLength: 8,
      maxLength: 8,
      mask: "### ### ###");

  static const Country cameroon = Country(
      name: 'Cameroon',
      alpha2: 'CM',
      alpha3: 'CMR',
      flagEmoji: '🇨🇲',
      flagImagePath: 'assets/flags/cm.png',
      dialCode: 237,
      minLength: 8,
      maxLength: 8,
      mask: "#### ####");

  static const Country canada = Country(
      name: 'Canada',
      alpha2: 'CA',
      alpha3: 'CAN',
      flagEmoji: '🇨🇦',
      flagImagePath: 'assets/flags/ca.png',
      dialCode: 1,
      minLength: 10,
      maxLength: 10,
      mask: "### ### ####");

  static const Country capeVerde = Country(
      name: 'Cape Verde',
      alpha2: 'CV',
      alpha3: 'CPV',
      flagEmoji: '🇨🇻',
      flagImagePath: 'assets/flags/cv.png',
      dialCode: 238,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country centralAfricanRepublic = Country(
      name: 'Central African Republic',
      alpha2: 'CF',
      alpha3: 'CAF',
      flagEmoji: '🇨🇫',
      flagImagePath: 'assets/flags/cf.png',
      dialCode: 236,
      minLength: 8,
      maxLength: 8,
      mask: "## ## ## ##");

  static const Country chad = Country(
      name: 'Chad',
      alpha2: 'TD',
      alpha3: 'TCD',
      flagEmoji: '🇹🇩',
      flagImagePath: 'assets/flags/td.png',
      dialCode: 235,
      minLength: 8,
      maxLength: 8,
      mask: "## ## ## ##");

  static const Country chile = Country(
      name: 'Chile',
      alpha2: 'CL',
      alpha3: 'CHL',
      flagEmoji: '🇨🇱',
      flagImagePath: 'assets/flags/cl.png',
      dialCode: 56,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country china = Country(
      name: 'China',
      alpha2: 'CN',
      alpha3: 'CHN',
      flagEmoji: '🇨🇳',
      flagImagePath: 'assets/flags/cn.png',
      dialCode: 86,
      minLength: 11,
      maxLength: 11,
      mask: "### #### ####");

  static const Country colombia = Country(
      name: 'Colombia',
      alpha2: 'CO',
      alpha3: 'COL',
      flagEmoji: '🇨🇴',
      flagImagePath: 'assets/flags/co.png',
      dialCode: 57,
      minLength: 10,
      maxLength: 10,
      mask: "### ### ####");

  static const Country comoros = Country(
      name: 'Comoros',
      alpha2: 'KM',
      alpha3: 'COM',
      flagEmoji: '🇰🇲',
      flagImagePath: 'assets/flags/km.png',
      dialCode: 269,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country congoDemocraticRepublic = Country(
      name: 'Congo (Democratic Republic)',
      alpha2: 'CD',
      alpha3: 'COD',
      flagEmoji: '🇨🇩',
      flagImagePath: 'assets/flags/cd.png',
      dialCode: 243,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country congoRepublic = Country(
      name: 'Congo (Republic)',
      alpha2: 'CG',
      alpha3: 'COG',
      flagEmoji: '🇨🇬',
      flagImagePath: 'assets/flags/cg.png',
      dialCode: 242,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country costaRica = Country(
      name: 'Costa Rica',
      alpha2: 'CR',
      alpha3: 'CRI',
      flagEmoji: '🇨🇷',
      flagImagePath: 'assets/flags/cr.png',
      dialCode: 506,
      minLength: 8,
      maxLength: 8,
      mask: "#### ####");

  static const Country coteDIvoire = Country(
      name: 'Côte d’Ivoire',
      alpha2: 'CI',
      alpha3: 'CIV',
      flagEmoji: '🇨🇮',
      flagImagePath: 'assets/flags/ci.png',
      dialCode: 225,
      minLength: 8,
      maxLength: 8,
      mask: "## ## ## ##");

  static const Country croatia = Country(
      name: 'Croatia',
      alpha2: 'HR',
      alpha3: 'HRV',
      flagEmoji: '🇭🇷',
      flagImagePath: 'assets/flags/hr.png',
      dialCode: 385,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country cuba = Country(
      name: 'Cuba',
      alpha2: 'CU',
      alpha3: 'CUB',
      flagEmoji: '🇨🇺',
      flagImagePath: 'assets/flags/cu.png',
      dialCode: 53,
      minLength: 8,
      maxLength: 8,
      mask: "### ### ###");

  static const Country cyprus = Country(
      name: 'Cyprus',
      alpha2: 'CY',
      alpha3: 'CYP',
      flagEmoji: '🇨🇾',
      flagImagePath: 'assets/flags/cy.png',
      dialCode: 357,
      minLength: 8,
      maxLength: 8,
      mask: "## ### ###");

  static const Country czechRepublic = Country(
      name: 'Czech Republic',
      alpha2: 'CZ',
      alpha3: 'CZE',
      flagEmoji: '🇨🇿',
      flagImagePath: 'assets/flags/cz.png',
      dialCode: 420,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country denmark = Country(
      name: 'Denmark',
      alpha2: 'DK',
      alpha3: 'DNK',
      flagEmoji: '🇩🇰',
      flagImagePath: 'assets/flags/dk.png',
      dialCode: 45,
      minLength: 8,
      maxLength: 8,
      mask: "## ## ## ##");

  static const Country djibouti = Country(
      name: 'Djibouti',
      alpha2: 'DJ',
      alpha3: 'DJI',
      flagEmoji: '🇩🇯',
      flagImagePath: 'assets/flags/dj.png',
      dialCode: 253,
      minLength: 8,
      maxLength: 8,
      mask: "## ## ## ##");

  static const Country dominica = Country(
      name: 'Dominica',
      alpha2: 'DM',
      alpha3: 'DMA',
      flagEmoji: '🇩🇲',
      flagImagePath: 'assets/flags/dm.png',
      dialCode: 1,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country dominicanRepublic = Country(
      name: 'Dominican Republic',
      alpha2: 'DO',
      alpha3: 'DOM',
      flagEmoji: '🇩🇴',
      flagImagePath: 'assets/flags/do.png',
      dialCode: 1,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country eastTimor = Country(
      name: 'East Timor',
      alpha2: 'TL',
      alpha3: 'TLS',
      flagEmoji: '🇹🇱',
      flagImagePath: 'assets/flags/tl.png',
      dialCode: 670,
      minLength: 8,
      maxLength: 8,
      mask: "### ### ##");

  static const Country ecuador = Country(
      name: 'Ecuador',
      alpha2: 'EC',
      alpha3: 'ECU',
      flagEmoji: '🇪🇨',
      flagImagePath: 'assets/flags/ec.png',
      dialCode: 593,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country egypt = Country(
      name: 'Egypt',
      alpha2: 'EG',
      alpha3: 'EGY',
      flagEmoji: '🇪🇬',
      flagImagePath: 'assets/flags/eg.png',
      dialCode: 20,
      minLength: 10,
      maxLength: 10,
      mask: "## ### ####");

  static const Country elSalvador = Country(
      name: 'El Salvador',
      alpha2: 'SV',
      alpha3: 'SLV',
      flagEmoji: '🇸🇻',
      flagImagePath: 'assets/flags/sv.png',
      dialCode: 503,
      minLength: 8,
      maxLength: 8,
      mask: "#### ####");

  static const Country equatorialGuinea = Country(
      name: 'Equatorial Guinea',
      alpha2: 'GQ',
      alpha3: 'GNQ',
      flagEmoji: '🇬🇶',
      flagImagePath: 'assets/flags/gq.png',
      dialCode: 240,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country eritrea = Country(
      name: 'Eritrea',
      alpha2: 'ER',
      alpha3: 'ERI',
      flagEmoji: '🇪🇷',
      flagImagePath: 'assets/flags/er.png',
      dialCode: 291,
      minLength: 7,
      maxLength: 7,
      mask: "### ###");

  static const Country estonia = Country(
      name: 'Estonia',
      alpha2: 'EE',
      alpha3: 'EST',
      flagEmoji: '🇪🇪',
      flagImagePath: 'assets/flags/ee.png',
      dialCode: 372,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country ethiopia = Country(
      name: 'Ethiopia',
      alpha2: 'ET',
      alpha3: 'ETH',
      flagEmoji: '🇪🇹',
      flagImagePath: 'assets/flags/et.png',
      dialCode: 251,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country fiji = Country(
      name: 'Fiji',
      alpha2: 'FJ',
      alpha3: 'FJI',
      flagEmoji: '🇫🇯',
      flagImagePath: 'assets/flags/fj.png',
      dialCode: 679,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country finland = Country(
      name: 'Finland',
      alpha2: 'FI',
      alpha3: 'FIN',
      flagEmoji: '🇫🇮',
      flagImagePath: 'assets/flags/fi.png',
      dialCode: 358,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country france = Country(
      name: 'France',
      alpha2: 'FR',
      alpha3: 'FRA',
      flagEmoji: '🇫🇷',
      flagImagePath: 'assets/flags/fr.png',
      dialCode: 33,
      minLength: 9,
      maxLength: 9,
      mask: "## ## ## ## ##");

  static const Country gabon = Country(
      name: 'Gabon',
      alpha2: 'GA',
      alpha3: 'GAB',
      flagEmoji: '🇬🇦',
      flagImagePath: 'assets/flags/ga.png',
      dialCode: 241,
      minLength: 8,
      maxLength: 8,
      mask: "## ## ## ##");

  static const Country gambia = Country(
      name: 'Gambia',
      alpha2: 'GM',
      alpha3: 'GMB',
      flagEmoji: '🇬🇲',
      flagImagePath: 'assets/flags/gm.png',
      dialCode: 220,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country georgia = Country(
      name: 'Georgia',
      alpha2: 'GE',
      alpha3: 'GEO',
      flagEmoji: '🇬🇪',
      flagImagePath: 'assets/flags/ge.png',
      dialCode: 995,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country germany = Country(
      name: 'Germany',
      alpha2: 'DE',
      alpha3: 'DEU',
      flagEmoji: '🇩🇪',
      flagImagePath: 'assets/flags/de.png',
      dialCode: 49,
      minLength: 11,
      maxLength: 11,
      mask: "### #### ####");

  static const Country ghana = Country(
      name: 'Ghana',
      alpha2: 'GH',
      alpha3: 'GHA',
      flagEmoji: '🇬🇭',
      flagImagePath: 'assets/flags/gh.png',
      dialCode: 233,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country greece = Country(
      name: 'Greece',
      alpha2: 'GR',
      alpha3: 'GRC',
      flagEmoji: '🇬🇷',
      flagImagePath: 'assets/flags/gr.png',
      dialCode: 30,
      minLength: 10,
      maxLength: 10,
      mask: "### ### ####");

  static const Country grenada = Country(
      name: 'Grenada',
      alpha2: 'GD',
      alpha3: 'GRD',
      flagEmoji: '🇬🇩',
      flagImagePath: 'assets/flags/gd.png',
      dialCode: 1,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country guatemala = Country(
      name: 'Guatemala',
      alpha2: 'GT',
      alpha3: 'GTM',
      flagEmoji: '🇬🇹',
      flagImagePath: 'assets/flags/gt.png',
      dialCode: 502,
      minLength: 8,
      maxLength: 8,
      mask: "#### ####");

  static const Country guinea = Country(
      name: 'Guinea',
      alpha2: 'GN',
      alpha3: 'GIN',
      flagEmoji: '🇬🇳',
      flagImagePath: 'assets/flags/gn.png',
      dialCode: 224,
      minLength: 8,
      maxLength: 8,
      mask: "## ### ###");

  static const Country guineaBissau = Country(
      name: 'Guinea-Bissau',
      alpha2: 'GW',
      alpha3: 'GNB',
      flagEmoji: '🇬🇼',
      flagImagePath: 'assets/flags/gw.png',
      dialCode: 245,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country guyana = Country(
      name: 'Guyana',
      alpha2: 'GY',
      alpha3: 'GUY',
      flagEmoji: '🇬🇾',
      flagImagePath: 'assets/flags/gy.png',
      dialCode: 592,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country haiti = Country(
      name: 'Haiti',
      alpha2: 'HT',
      alpha3: 'HTI',
      flagEmoji: '🇭🇹',
      flagImagePath: 'assets/flags/ht.png',
      dialCode: 509,
      minLength: 8,
      maxLength: 8,
      mask: "## ## ####");

  static const Country honduras = Country(
      name: 'Honduras',
      alpha2: 'HN',
      alpha3: 'HND',
      flagEmoji: '🇭🇳',
      flagImagePath: 'assets/flags/hn.png',
      dialCode: 504,
      minLength: 8,
      maxLength: 8,
      mask: "#### ####");

  static const Country hungary = Country(
      name: 'Hungary',
      alpha2: 'HU',
      alpha3: 'HUN',
      flagEmoji: '🇭🇺',
      flagImagePath: 'assets/flags/hu.png',
      dialCode: 36,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country iceland = Country(
      name: 'Iceland',
      alpha2: 'IS',
      alpha3: 'ISL',
      flagEmoji: '🇮🇸',
      flagImagePath: 'assets/flags/is.png',
      dialCode: 354,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country india = Country(
      name: 'India',
      alpha2: 'IN',
      alpha3: 'IND',
      flagEmoji: '🇮🇳',
      flagImagePath: 'assets/flags/in.png',
      dialCode: 91,
      minLength: 10,
      maxLength: 10,
      mask: "## #### ####");

  static const Country indonesia = Country(
      name: 'Indonesia',
      alpha2: 'ID',
      alpha3: 'IDN',
      flagEmoji: '🇮🇩',
      flagImagePath: 'assets/flags/id.png',
      dialCode: 62,
      minLength: 10,
      maxLength: 10,
      mask: "## #### ####");

  static const Country iran = Country(
      name: 'Iran',
      alpha2: 'IR',
      alpha3: 'IRN',
      flagEmoji: '🇮🇷',
      flagImagePath: 'assets/flags/ir.png',
      dialCode: 98,
      minLength: 10,
      maxLength: 10,
      mask: "### #### ####");

  static const Country iraq = Country(
      name: 'Iraq',
      alpha2: 'IQ',
      alpha3: 'IRQ',
      flagEmoji: '🇮🇶',
      flagImagePath: 'assets/flags/iq.png',
      dialCode: 964,
      minLength: 10,
      maxLength: 10,
      mask: "### #### ####");

  static const Country ireland = Country(
      name: 'Ireland',
      alpha2: 'IE',
      alpha3: 'IRL',
      flagEmoji: '🇮🇪',
      flagImagePath: 'assets/flags/ie.png',
      dialCode: 353,
      minLength: 9,
      maxLength: 9,
      mask: "## ### ####");

  static const Country israel = Country(
      name: "Israel",
      alpha2: 'IL',
      alpha3: 'ISR',
      flagEmoji: '🇮🇱',
      flagImagePath: 'assets/flags/il.png',
      dialCode: 972,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ####");

  static const Country italy = Country(
      name: 'Italy',
      alpha2: 'IT',
      alpha3: 'ITA',
      flagEmoji: '🇮🇹',
      flagImagePath: 'assets/flags/it.png',
      dialCode: 39,
      minLength: 10,
      maxLength: 10,
      mask: "## #### ####");

  static const Country jamaica = Country(
      name: 'Jamaica',
      alpha2: 'JM',
      alpha3: 'JAM',
      flagEmoji: '🇯🇲',
      flagImagePath: 'assets/flags/jm.png',
      dialCode: 1,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country japan = Country(
      name: 'Japan',
      alpha2: 'JP',
      alpha3: 'JPN',
      flagEmoji: '🇯🇵',
      flagImagePath: 'assets/flags/jp.png',
      dialCode: 81,
      minLength: 10,
      maxLength: 10,
      mask: "## #### ####");

  static const Country jordan = Country(
      name: 'Jordan',
      alpha2: 'JO',
      alpha3: 'JOR',
      flagEmoji: '🇯🇴',
      flagImagePath: 'assets/flags/jo.png',
      dialCode: 962,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ####");

  static const Country kazakhstan = Country(
      name: 'Kazakhstan',
      alpha2: 'KZ',
      alpha3: 'KAZ',
      flagEmoji: '🇰🇿',
      flagImagePath: 'assets/flags/kz.png',
      dialCode: 7,
      minLength: 10,
      maxLength: 10,
      mask: "### ### ####");

  static const Country kenya = Country(
      name: 'Kenya',
      alpha2: 'KE',
      alpha3: 'KEN',
      flagEmoji: '🇰🇪',
      flagImagePath: 'assets/flags/ke.png',
      dialCode: 254,
      minLength: 10,
      maxLength: 10,
      mask: "### ### ###");

  static const Country kiribati = Country(
      name: 'Kiribati',
      alpha2: 'KI',
      alpha3: 'KIR',
      flagEmoji: '🇰🇮',
      flagImagePath: 'assets/flags/ki.png',
      dialCode: 686,
      minLength: 5,
      maxLength: 5,
      mask: "#####");

  static const Country northKorea = Country(
      name: 'North Korea',
      alpha2: 'KP',
      alpha3: 'PRK',
      flagEmoji: '🇰🇵',
      flagImagePath: 'assets/flags/kp.png',
      dialCode: 850,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country southKorea = Country(
      name: 'South Korea',
      alpha2: 'KR',
      alpha3: 'KOR',
      flagEmoji: '🇰🇷',
      flagImagePath: 'assets/flags/kr.png',
      dialCode: 82,
      minLength: 10,
      maxLength: 10,
      mask: "## #### ####");

  static const Country kosovo = Country(
      name: 'Kosovo',
      alpha2: 'XK',
      alpha3: 'XKX',
      flagEmoji: '🇽🇰',
      flagImagePath: 'assets/flags/xk.png',
      dialCode: 383,
      minLength: 8,
      maxLength: 8,
      mask: "### ### ###");

  static const Country kuwait = Country(
      name: 'Kuwait',
      alpha2: 'KW',
      alpha3: 'KWT',
      flagEmoji: '🇰🇼',
      flagImagePath: 'assets/flags/kw.png',
      dialCode: 965,
      minLength: 8,
      maxLength: 8,
      mask: "#### ####");

  static const Country kyrgyzstan = Country(
      name: 'Kyrgyzstan',
      alpha2: 'KG',
      alpha3: 'KGZ',
      flagEmoji: '🇰🇬',
      flagImagePath: 'assets/flags/kg.png',
      dialCode: 996,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country laos = Country(
      name: 'Laos',
      alpha2: 'LA',
      alpha3: 'LAO',
      flagEmoji: '🇱🇦',
      flagImagePath: 'assets/flags/la.png',
      dialCode: 856,
      minLength: 8,
      maxLength: 8,
      mask: "### ### ###");

  static const Country latvia = Country(
      name: 'Latvia',
      alpha2: 'LV',
      alpha3: 'LVA',
      flagEmoji: '🇱🇻',
      flagImagePath: 'assets/flags/lv.png',
      dialCode: 371,
      minLength: 8,
      maxLength: 8,
      mask: "## ### ###");

  static const Country lebanon = Country(
      name: 'Lebanon',
      alpha2: 'LB',
      alpha3: 'LBN',
      flagEmoji: '🇱🇧',
      flagImagePath: 'assets/flags/lb.png',
      dialCode: 961,
      minLength: 8,
      maxLength: 8,
      mask: "## ### ###");

  static const Country lesotho = Country(
      name: 'Lesotho',
      alpha2: 'LS',
      alpha3: 'LSO',
      flagEmoji: '🇱🇸',
      flagImagePath: 'assets/flags/ls.png',
      dialCode: 266,
      minLength: 8,
      maxLength: 8,
      mask: "## ### ###");

  static const Country liberia = Country(
      name: 'Liberia',
      alpha2: 'LR',
      alpha3: 'LBR',
      flagEmoji: '🇱🇷',
      flagImagePath: 'assets/flags/lr.png',
      dialCode: 231,
      minLength: 8,
      maxLength: 8,
      mask: "## ### ###");

  static const Country libya = Country(
      name: 'Libya',
      alpha2: 'LY',
      alpha3: 'LBY',
      flagEmoji: '🇱🇾',
      flagImagePath: 'assets/flags/ly.png',
      dialCode: 218,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country liechtenstein = Country(
      name: 'Liechtenstein',
      alpha2: 'LI',
      alpha3: 'LIE',
      flagEmoji: '🇱🇮',
      flagImagePath: 'assets/flags/li.png',
      dialCode: 423,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country lithuania = Country(
      name: 'Lithuania',
      alpha2: 'LT',
      alpha3: 'LTU',
      flagEmoji: '🇱🇹',
      flagImagePath: 'assets/flags/lt.png',
      dialCode: 370,
      minLength: 8,
      maxLength: 8,
      mask: "### ### ###");

  static const Country luxembourg = Country(
      name: 'Luxembourg',
      alpha2: 'LU',
      alpha3: 'LUX',
      flagEmoji: '🇱🇺',
      flagImagePath: 'assets/flags/lu.png',
      dialCode: 352,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country macedonia = Country(
      name: 'Macedonia',
      alpha2: 'MK',
      alpha3: 'MKD',
      flagEmoji: '🇲🇰',
      flagImagePath: 'assets/flags/mk.png',
      dialCode: 389,
      minLength: 8,
      maxLength: 8,
      mask: "## ### ###");

  static const Country madagascar = Country(
      name: 'Madagascar',
      alpha2: 'MG',
      alpha3: 'MDG',
      flagEmoji: '🇲🇬',
      flagImagePath: 'assets/flags/mg.png',
      dialCode: 261,
      minLength: 9,
      maxLength: 9,
      mask: "## ## ### ##");

  static const Country malawi = Country(
      name: 'Malawi',
      alpha2: 'MW',
      alpha3: 'MWI',
      flagEmoji: '🇲🇼',
      flagImagePath: 'assets/flags/mw.png',
      dialCode: 265,
      minLength: 9,
      maxLength: 9,
      mask: "## ### ####");

  static const Country malaysia = Country(
      name: 'Malaysia',
      alpha2: 'MY',
      alpha3: 'MYS',
      flagEmoji: '🇲🇾',
      flagImagePath: 'assets/flags/my.png',
      dialCode: 60,
      minLength: 9,
      maxLength: 9,
      mask: "## #### ####");

  static const Country maldives = Country(
      name: 'Maldives',
      alpha2: 'MV',
      alpha3: 'MDV',
      flagEmoji: '🇲🇻',
      flagImagePath: 'assets/flags/mv.png',
      dialCode: 960,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country mali = Country(
      name: 'Mali',
      alpha2: 'ML',
      alpha3: 'MLI',
      flagEmoji: '🇲🇱',
      flagImagePath: 'assets/flags/ml.png',
      dialCode: 223,
      minLength: 8,
      maxLength: 8,
      mask: "## ## ####");

  static const Country malta = Country(
      name: 'Malta',
      alpha2: 'MT',
      alpha3: 'MLT',
      flagEmoji: '🇲🇹',
      flagImagePath: 'assets/flags/mt.png',
      dialCode: 356,
      minLength: 8,
      maxLength: 8,
      mask: "## ####");

  static const Country marshallIslands = Country(
      name: 'Marshall Islands',
      alpha2: 'MH',
      alpha3: 'MHL',
      flagEmoji: '🇲🇭',
      flagImagePath: 'assets/flags/mh.png',
      dialCode: 692,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country mauritania = Country(
      name: 'Mauritania',
      alpha2: 'MR',
      alpha3: 'MRT',
      flagEmoji: '🇲🇷',
      flagImagePath: 'assets/flags/mr.png',
      dialCode: 222,
      minLength: 8,
      maxLength: 8,
      mask: "## ## ####");

  static const Country mauritius = Country(
      name: 'Mauritius',
      alpha2: 'MU',
      alpha3: 'MUS',
      flagEmoji: '🇲🇺',
      flagImagePath: 'assets/flags/mu.png',
      dialCode: 230,
      minLength: 8,
      maxLength: 8,
      mask: "### ####");

  static const Country mexico = Country(
      name: 'Mexico',
      alpha2: 'MX',
      alpha3: 'MEX',
      flagEmoji: '🇲🇽',
      flagImagePath: 'assets/flags/mx.png',
      dialCode: 52,
      minLength: 10,
      maxLength: 10,
      mask: "## #### ####");

  static const Country micronesia = Country(
      name: 'Micronesia',
      alpha2: 'FM',
      alpha3: 'FSM',
      flagEmoji: '🇫🇲',
      flagImagePath: 'assets/flags/fm.png',
      dialCode: 691,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country moldova = Country(
      name: 'Moldova',
      alpha2: 'MD',
      alpha3: 'MDA',
      flagEmoji: '🇲🇩',
      flagImagePath: 'assets/flags/md.png',
      dialCode: 373,
      minLength: 8,
      maxLength: 8,
      mask: "## ### ###");

  static const Country monaco = Country(
      name: 'Monaco',
      alpha2: 'MC',
      alpha3: 'MCO',
      flagEmoji: '🇲🇨',
      flagImagePath: 'assets/flags/mc.png',
      dialCode: 377,
      minLength: 8,
      maxLength: 8,
      mask: "## ## ## ##");

  static const Country mongolia = Country(
      name: 'Mongolia',
      alpha2: 'MN',
      alpha3: 'MNG',
      flagEmoji: '🇲🇳',
      flagImagePath: 'assets/flags/mn.png',
      dialCode: 976,
      minLength: 8,
      maxLength: 8,
      mask: "## ### ###");

  static const Country montenegro = Country(
      name: 'Montenegro',
      alpha2: 'ME',
      alpha3: 'MNE',
      flagEmoji: '🇲🇪',
      flagImagePath: 'assets/flags/me.png',
      dialCode: 382,
      minLength: 8,
      maxLength: 8,
      mask: "## ### ###");

  static const Country morocco = Country(
      name: 'Morocco',
      alpha2: 'MA',
      alpha3: 'MAR',
      flagEmoji: '🇲🇦',
      flagImagePath: 'assets/flags/ma.png',
      dialCode: 212,
      minLength: 9,
      maxLength: 9,
      mask: "## ### ####");

  static const Country mozambique = Country(
      name: 'Mozambique',
      alpha2: 'MZ',
      alpha3: 'MOZ',
      flagEmoji: '🇲🇿',
      flagImagePath: 'assets/flags/mz.png',
      dialCode: 258,
      minLength: 9,
      maxLength: 9,
      mask: "## ### ####");

  static const Country myanmar = Country(
      name: 'Myanmar',
      alpha2: 'MM',
      alpha3: 'MMR',
      flagEmoji: '🇲🇲',
      flagImagePath: 'assets/flags/mm.png',
      dialCode: 95,
      minLength: 8,
      maxLength: 8,
      mask: "## ### ###");

  static const Country namibia = Country(
      name: 'Namibia',
      alpha2: 'NA',
      alpha3: 'NAM',
      flagEmoji: '🇳🇦',
      flagImagePath: 'assets/flags/na.png',
      dialCode: 264,
      minLength: 8,
      maxLength: 8,
      mask: "### ####");

  static const Country nauru = Country(
      name: 'Nauru',
      alpha2: 'NR',
      alpha3: 'NRU',
      flagEmoji: '🇳🇷',
      flagImagePath: 'assets/flags/nr.png',
      dialCode: 674,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country nepal = Country(
      name: 'Nepal',
      alpha2: 'NP',
      alpha3: 'NPL',
      flagEmoji: '🇳🇵',
      flagImagePath: 'assets/flags/np.png',
      dialCode: 977,
      minLength: 10,
      maxLength: 10,
      mask: "## #### ####");

  static const Country netherlands = Country(
      name: 'Netherlands',
      alpha2: 'NL',
      alpha3: 'NLD',
      flagEmoji: '🇳🇱',
      flagImagePath: 'assets/flags/nl.png',
      dialCode: 31,
      minLength: 10,
      maxLength: 10,
      mask: "## ### ####");

  static const Country newZealand = Country(
      name: 'New Zealand',
      alpha2: 'NZ',
      alpha3: 'NZL',
      flagEmoji: '🇳🇿',
      flagImagePath: 'assets/flags/nz.png',
      dialCode: 64,
      minLength: 9,
      maxLength: 9,
      mask: "## #### ####");

  static const Country nicaragua = Country(
      name: 'Nicaragua',
      alpha2: 'NI',
      alpha3: 'NIC',
      flagEmoji: '🇳🇮',
      flagImagePath: 'assets/flags/ni.png',
      dialCode: 505,
      minLength: 8,
      maxLength: 8,
      mask: "#### ####");

  static const Country niger = Country(
      name: 'Niger',
      alpha2: 'NE',
      alpha3: 'NER',
      flagEmoji: '🇳🇪',
      flagImagePath: 'assets/flags/ne.png',
      dialCode: 227,
      minLength: 8,
      maxLength: 8,
      mask: "## ## ####");

  static const Country nigeria = Country(
      name: 'Nigeria',
      alpha2: 'NG',
      alpha3: 'NGA',
      flagEmoji: '🇳🇬',
      flagImagePath: 'assets/flags/ng.png',
      dialCode: 234,
      minLength: 10,
      maxLength: 10,
      mask: "### #### ####");

  static const Country norway = Country(
      name: 'Norway',
      alpha2: 'NO',
      alpha3: 'NOR',
      flagEmoji: '🇳🇴',
      flagImagePath: 'assets/flags/no.png',
      dialCode: 47,
      minLength: 8,
      maxLength: 8,
      mask: "#### ####");

  static const Country oman = Country(
      name: 'Oman',
      alpha2: 'OM',
      alpha3: 'OMN',
      flagEmoji: '🇴🇲',
      flagImagePath: 'assets/flags/om.png',
      dialCode: 968,
      minLength: 8,
      maxLength: 8,
      mask: "### ####");

  static const Country pakistan = Country(
      name: 'Pakistan',
      alpha2: 'PK',
      alpha3: 'PAK',
      flagEmoji: '🇵🇰',
      flagImagePath: 'assets/flags/pk.png',
      dialCode: 92,
      minLength: 10,
      maxLength: 10,
      mask: "## #### ####");

  static const Country palau = Country(
      name: 'Palau',
      alpha2: 'PW',
      alpha3: 'PLW',
      flagEmoji: '🇵🇼',
      flagImagePath: 'assets/flags/pw.png',
      dialCode: 680,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country panama = Country(
      name: 'Panama',
      alpha2: 'PA',
      alpha3: 'PAN',
      flagEmoji: '🇵🇦',
      flagImagePath: 'assets/flags/pa.png',
      dialCode: 507,
      minLength: 8,
      maxLength: 8,
      mask: "#### ####");

  static const Country papuaNewGuinea = Country(
      name: 'Papua New Guinea',
      alpha2: 'PG',
      alpha3: 'PNG',
      flagEmoji: '🇵🇬',
      flagImagePath: 'assets/flags/pg.png',
      dialCode: 675,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country paraguay = Country(
      name: 'Paraguay',
      alpha2: 'PY',
      alpha3: 'PRY',
      flagEmoji: '🇵🇾',
      flagImagePath: 'assets/flags/py.png',
      dialCode: 595,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country peru = Country(
      name: 'Peru',
      alpha2: 'PE',
      alpha3: 'PER',
      flagEmoji: '🇵🇪',
      flagImagePath: 'assets/flags/pe.png',
      dialCode: 51,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country philippines = Country(
      name: 'Philippines',
      alpha2: 'PH',
      alpha3: 'PHL',
      flagEmoji: '🇵🇭',
      flagImagePath: 'assets/flags/ph.png',
      dialCode: 63,
      minLength: 10,
      maxLength: 10,
      mask: "## #### ####");

  static const Country poland = Country(
      name: 'Poland',
      alpha2: 'PL',
      alpha3: 'POL',
      flagEmoji: '🇵🇱',
      flagImagePath: 'assets/flags/pl.png',
      dialCode: 48,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country portugal = Country(
      name: 'Portugal',
      alpha2: 'PT',
      alpha3: 'PRT',
      flagEmoji: '🇵🇹',
      flagImagePath: 'assets/flags/pt.png',
      dialCode: 351,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country qatar = Country(
      name: 'Qatar',
      alpha2: 'QA',
      alpha3: 'QAT',
      flagEmoji: '🇶🇦',
      flagImagePath: 'assets/flags/qa.png',
      dialCode: 974,
      minLength: 8,
      maxLength: 8,
      mask: "#### ####");

  static const Country romania = Country(
      name: 'Romania',
      alpha2: 'RO',
      alpha3: 'ROU',
      flagEmoji: '🇷🇴',
      flagImagePath: 'assets/flags/ro.png',
      dialCode: 40,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country russia = Country(
      name: 'Russia',
      alpha2: 'RU',
      alpha3: 'RUS',
      flagEmoji: '🇷🇺',
      flagImagePath: 'assets/flags/ru.png',
      dialCode: 7,
      minLength: 10,
      maxLength: 10,
      mask: "### ### ####");

  static const Country rwanda = Country(
      name: 'Rwanda',
      alpha2: 'RW',
      alpha3: 'RWA',
      flagEmoji: '🇷🇼',
      flagImagePath: 'assets/flags/rw.png',
      dialCode: 250,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country saintKittsAndNevis = Country(
      name: 'Saint Kitts and Nevis',
      alpha2: 'KN',
      alpha3: 'KNA',
      flagEmoji: '🇰🇳',
      flagImagePath: 'assets/flags/kn.png',
      dialCode: 1,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country saintLucia = Country(
      name: 'Saint Lucia',
      alpha2: 'LC',
      alpha3: 'LCA',
      flagEmoji: '🇱🇨',
      flagImagePath: 'assets/flags/lc.png',
      dialCode: 1,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country saintVincentAndTheGrenadines = Country(
      name: 'Saint Vincent and the Grenadines',
      alpha2: 'VC',
      alpha3: 'VCT',
      flagEmoji: '🇻🇨',
      flagImagePath: 'assets/flags/vc.png',
      dialCode: 1,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country samoa = Country(
      name: 'Samoa',
      alpha2: 'WS',
      alpha3: 'WSM',
      flagEmoji: '🇼🇸',
      flagImagePath: 'assets/flags/ws.png',
      dialCode: 685,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country sanMarino = Country(
      name: 'San Marino',
      alpha2: 'SM',
      alpha3: 'SMR',
      flagEmoji: '🇸🇲',
      flagImagePath: 'assets/flags/sm.png',
      dialCode: 378,
      minLength: 8,
      maxLength: 8,
      mask: "## ## ## ##");

  static const Country saoTomeAndPrincipe = Country(
      name: 'Sao Tome and Principe',
      alpha2: 'ST',
      alpha3: 'STP',
      flagEmoji: '🇸🇹',
      flagImagePath: 'assets/flags/st.png',
      dialCode: 239,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country saudiArabia = Country(
      name: 'Saudi Arabia',
      alpha2: 'SA',
      alpha3: 'SAU',
      flagEmoji: '🇸🇦',
      flagImagePath: 'assets/flags/sa.png',
      dialCode: 966,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ####");

  static const Country senegal = Country(
      name: 'Senegal',
      alpha2: 'SN',
      alpha3: 'SEN',
      flagEmoji: '🇸🇳',
      flagImagePath: 'assets/flags/sn.png',
      dialCode: 221,
      minLength: 9,
      maxLength: 9,
      mask: "## ### ####");

  static const Country serbia = Country(
      name: 'Serbia',
      alpha2: 'RS',
      alpha3: 'SRB',
      flagEmoji: '🇷🇸',
      flagImagePath: 'assets/flags/rs.png',
      dialCode: 381,
      minLength: 8,
      maxLength: 8,
      mask: "## ### ###");

  static const Country seychelles = Country(
      name: 'Seychelles',
      alpha2: 'SC',
      alpha3: 'SYC',
      flagEmoji: '🇸🇨',
      flagImagePath: 'assets/flags/sc.png',
      dialCode: 248,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country sierraLeone = Country(
      name: 'Sierra Leone',
      alpha2: 'SL',
      alpha3: 'SLE',
      flagEmoji: '🇸🇱',
      flagImagePath: 'assets/flags/sl.png',
      dialCode: 232,
      minLength: 8,
      maxLength: 8,
      mask: "## #### ####");

  static const Country singapore = Country(
      name: 'Singapore',
      alpha2: 'SG',
      alpha3: 'SGP',
      flagEmoji: '🇸🇬',
      flagImagePath: 'assets/flags/sg.png',
      dialCode: 65,
      minLength: 8,
      maxLength: 8,
      mask: "#### ####");

  static const Country slovakia = Country(
      name: 'Slovakia',
      alpha2: 'SK',
      alpha3: 'SVK',
      flagEmoji: '🇸🇰',
      flagImagePath: 'assets/flags/sk.png',
      dialCode: 421,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country slovenia = Country(
      name: 'Slovenia',
      alpha2: 'SI',
      alpha3: 'SVN',
      flagEmoji: '🇸🇮',
      flagImagePath: 'assets/flags/si.png',
      dialCode: 386,
      minLength: 8,
      maxLength: 8,
      mask: "## ### ###");

  static const Country solomonIslands = Country(
      name: 'Solomon Islands',
      alpha2: 'SB',
      alpha3: 'SLB',
      flagEmoji: '🇸🇧',
      flagImagePath: 'assets/flags/sb.png',
      dialCode: 677,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country somalia = Country(
      name: 'Somalia',
      alpha2: 'SO',
      alpha3: 'SOM',
      flagEmoji: '🇸🇴',
      flagImagePath: 'assets/flags/so.png',
      dialCode: 252,
      minLength: 8,
      maxLength: 8,
      mask: "## ### ###");

  static const Country southAfrica = Country(
      name: 'South Africa',
      alpha2: 'ZA',
      alpha3: 'ZAF',
      flagEmoji: '🇿🇦',
      flagImagePath: 'assets/flags/za.png',
      dialCode: 27,
      minLength: 9,
      maxLength: 9,
      mask: "## ### ####");

  static const Country spain = Country(
      name: 'Spain',
      alpha2: 'ES',
      alpha3: 'ESP',
      flagEmoji: '🇪🇸',
      flagImagePath: 'assets/flags/es.png',
      dialCode: 34,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country sriLanka = Country(
      name: 'Sri Lanka',
      alpha2: 'LK',
      alpha3: 'LKA',
      flagEmoji: '🇱🇰',
      flagImagePath: 'assets/flags/lk.png',
      dialCode: 94,
      minLength: 9,
      maxLength: 9,
      mask: "## ### ####");

  static const Country sudan = Country(
      name: 'Sudan',
      alpha2: 'SD',
      alpha3: 'SDN',
      flagEmoji: '🇸🇩',
      flagImagePath: 'assets/flags/sd.png',
      dialCode: 249,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country suriname = Country(
      name: 'Suriname',
      alpha2: 'SR',
      alpha3: 'SUR',
      flagEmoji: '🇸🇷',
      flagImagePath: 'assets/flags/sr.png',
      dialCode: 597,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country swaziland = Country(
      name: 'Swaziland',
      alpha2: 'SZ',
      alpha3: 'SWZ',
      flagEmoji: '🇸🇿',
      flagImagePath: 'assets/flags/sz.png',
      dialCode: 268,
      minLength: 8,
      maxLength: 8,
      mask: "## ### ###");

  static const Country sweden = Country(
      name: 'Sweden',
      alpha2: 'SE',
      alpha3: 'SWE',
      flagEmoji: '🇸🇪',
      flagImagePath: 'assets/flags/se.png',
      dialCode: 46,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country switzerland = Country(
      name: 'Switzerland',
      alpha2: 'CH',
      alpha3: 'CHE',
      flagEmoji: '🇨🇭',
      flagImagePath: 'assets/flags/ch.png',
      dialCode: 41,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country syria = Country(
      name: 'Syria',
      alpha2: 'SY',
      alpha3: 'SYR',
      flagEmoji: '🇸🇾',
      flagImagePath: 'assets/flags/sy.png',
      dialCode: 963,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country taiwan = Country(
      name: 'Taiwan',
      alpha2: 'TW',
      alpha3: 'TWN',
      flagEmoji: '🇹🇼',
      flagImagePath: 'assets/flags/tw.png',
      dialCode: 886,
      minLength: 9,
      maxLength: 9,
      mask: "## ### ###");

  static const Country tajikistan = Country(
      name: 'Tajikistan',
      alpha2: 'TJ',
      alpha3: 'TJK',
      flagEmoji: '🇹🇯',
      flagImagePath: 'assets/flags/tj.png',
      dialCode: 992,
      minLength: 9,
      maxLength: 9,
      mask: "## ### ###");

  static const Country tanzania = Country(
      name: 'Tanzania',
      alpha2: 'TZ',
      alpha3: 'TZA',
      flagEmoji: '🇹🇿',
      flagImagePath: 'assets/flags/tz.png',
      dialCode: 255,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country thailand = Country(
      name: 'Thailand',
      alpha2: 'TH',
      alpha3: 'THA',
      flagEmoji: '🇹🇭',
      flagImagePath: 'assets/flags/th.png',
      dialCode: 66,
      minLength: 9,
      maxLength: 9,
      mask: "## ### ####");

  static const Country togo = Country(
      name: 'Togo',
      alpha2: 'TG',
      alpha3: 'TGO',
      flagEmoji: '🇹🇬',
      flagImagePath: 'assets/flags/tg.png',
      dialCode: 228,
      minLength: 8,
      maxLength: 8,
      mask: "## ### ###");

  static const Country tonga = Country(
      name: 'Tonga',
      alpha2: 'TO',
      alpha3: 'TON',
      flagEmoji: '🇹🇴',
      flagImagePath: 'assets/flags/to.png',
      dialCode: 676,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country trinidadAndTobago = Country(
      name: 'Trinidad and Tobago',
      alpha2: 'TT',
      alpha3: 'TTO',
      flagEmoji: '🇹🇹',
      flagImagePath: 'assets/flags/tt.png',
      dialCode: 1,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country tunisia = Country(
      name: 'Tunisia',
      alpha2: 'TN',
      alpha3: 'TUN',
      flagEmoji: '🇹🇳',
      flagImagePath: 'assets/flags/tn.png',
      dialCode: 216,
      minLength: 8,
      maxLength: 8,
      mask: "## ### ###");

  static const Country turkey = Country(
      name: 'Turkey',
      alpha2: 'TR',
      alpha3: 'TUR',
      flagEmoji: '🇹🇷',
      flagImagePath: 'assets/flags/tr.png',
      dialCode: 90,
      minLength: 10,
      maxLength: 10,
      mask: "### ### ####");

  static const Country turkmenistan = Country(
      name: 'Turkmenistan',
      alpha2: 'TM',
      alpha3: 'TKM',
      flagEmoji: '🇹🇲',
      flagImagePath: 'assets/flags/tm.png',
      dialCode: 993,
      minLength: 8,
      maxLength: 8,
      mask: "## ### ###");

  static const Country tuvalu = Country(
      name: 'Tuvalu',
      alpha2: 'TV',
      alpha3: 'TUV',
      flagEmoji: '🇹🇻',
      flagImagePath: 'assets/flags/tv.png',
      dialCode: 688,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country uganda = Country(
      name: 'Uganda',
      alpha2: 'UG',
      alpha3: 'UGA',
      flagEmoji: '🇺🇬',
      flagImagePath: 'assets/flags/ug.png',
      dialCode: 256,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country ukraine = Country(
      name: 'Ukraine',
      alpha2: 'UA',
      alpha3: 'UKR',
      flagEmoji: '🇺🇦',
      flagImagePath: 'assets/flags/ua.png',
      dialCode: 380,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country unitedArabEmirates = Country(
      name: 'United Arab Emirates',
      alpha2: 'AE',
      alpha3: 'ARE',
      flagEmoji: '🇦🇪',
      flagImagePath: 'assets/flags/ae.png',
      dialCode: 971,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country unitedKingdom = Country(
      name: 'United Kingdom',
      alpha2: 'GB',
      alpha3: 'GBR',
      flagEmoji: '🇬🇧',
      flagImagePath: 'assets/flags/gb.png',
      dialCode: 44,
      minLength: 10,
      maxLength: 10,
      mask: "## #### ####");

  static const Country unitedStates = Country(
      name: 'United States',
      alpha2: 'US',
      alpha3: 'USA',
      flagEmoji: '🇺🇸',
      flagImagePath: 'assets/flags/us.png',
      dialCode: 1,
      minLength: 10,
      maxLength: 10,
      mask: "### #### ###");

  static const Country uruguay = Country(
      name: 'Uruguay',
      alpha2: 'UY',
      alpha3: 'URY',
      flagEmoji: '🇺🇾',
      flagImagePath: 'assets/flags/uy.png',
      dialCode: 598,
      minLength: 8,
      maxLength: 8,
      mask: "### ### ###");

  static const Country uzbekistan = Country(
      name: 'Uzbekistan',
      alpha2: 'UZ',
      alpha3: 'UZB',
      flagEmoji: '🇺🇿',
      flagImagePath: 'assets/flags/uz.png',
      dialCode: 998,
      minLength: 9,
      maxLength: 9,
      mask: "## ### ###");

  static const Country vanuatu = Country(
      name: 'Vanuatu',
      alpha2: 'VU',
      alpha3: 'VUT',
      flagEmoji: '🇻🇺',
      flagImagePath: 'assets/flags/vu.png',
      dialCode: 678,
      minLength: 7,
      maxLength: 7,
      mask: "### ####");

  static const Country vaticanCity = Country(
      name: 'Vatican City',
      alpha2: 'VA',
      alpha3: 'VAT',
      flagEmoji: '🇻🇦',
      flagImagePath: 'assets/flags/va.png',
      dialCode: 379,
      minLength: 8,
      maxLength: 8,
      mask: "## ### ###");

  static const Country venezuela = Country(
      name: 'Venezuela',
      alpha2: 'VE',
      alpha3: 'VEN',
      flagEmoji: '🇻🇪',
      flagImagePath: 'assets/flags/ve.png',
      dialCode: 58,
      minLength: 10,
      maxLength: 10,
      mask: "### ### ####");

  static const Country vietnam = Country(
      name: 'Vietnam',
      alpha2: 'VN',
      alpha3: 'VNM',
      flagEmoji: '🇻🇳',
      flagImagePath: 'assets/flags/vn.png',
      dialCode: 84,
      minLength: 10,
      maxLength: 10,
      mask: "## #### ####");

  static const Country yemen = Country(
      name: 'Yemen',
      alpha2: 'YE',
      alpha3: 'YEM',
      flagEmoji: '🇾🇪',
      flagImagePath: 'assets/flags/ye.png',
      dialCode: 967,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country zambia = Country(
      name: 'Zambia',
      alpha2: 'ZM',
      alpha3: 'ZMB',
      flagEmoji: '🇿🇲',
      flagImagePath: 'assets/flags/zm.png',
      dialCode: 260,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");

  static const Country zimbabwe = Country(
      name: 'Zimbabwe',
      alpha2: 'ZW',
      alpha3: 'ZWE',
      flagEmoji: '🇿🇼',
      flagImagePath: 'assets/flags/zw.png',
      dialCode: 263,
      minLength: 9,
      maxLength: 9,
      mask: "### ### ###");
}
