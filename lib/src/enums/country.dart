/// Country metadata used by [EPhoneField].
library;

part 'country_data.dart';

// ignore_for_file: public_member_api_docs

/// Country metadata used by [EPhoneField].
class Country {
  /// Creates a country definition.
  const Country({
    required this.name,
    required this.alpha2,
    required this.alpha3,
    required this.flagEmoji,
    required this.flagImagePath,
    required this.dialCode,
    required this.minLength,
    required this.maxLength,
  });

  /// Display name.
  final String name;

  /// ISO 3166-1 alpha-2 code.
  final String alpha2;

  /// ISO 3166-1 alpha-3 code.
  final String alpha3;

  /// Unicode flag emoji.
  final String flagEmoji;

  /// Package asset path for the flag image.
  final String flagImagePath;

  /// International dialing code without plus sign.
  final int dialCode;

  /// Minimum national number length.
  ///
  /// Used only for length-based validation when native libphonenumber is
  /// unavailable.
  final int minLength;

  /// Maximum national number length.
  ///
  /// Used for input limiting and length validation when native as-you-type
  /// is unavailable.
  final int maxLength;

  /// All supported countries.
  static const List<Country> values = <Country>[
    afghanistan,
    albania,
    algeria,
    andorra,
    angola,
    antiguaAndBarbuda,
    argentina,
    armenia,
    australia,
    austria,
    azerbaijan,
    bahamas,
    bahrain,
    bangladesh,
    barbados,
    belarus,
    belgium,
    belize,
    benin,
    bhutan,
    bolivia,
    bosniaAndHerzegovina,
    botswana,
    brazil,
    brunei,
    bulgaria,
    burkinaFaso,
    burundi,
    cambodia,
    cameroon,
    canada,
    capeVerde,
    centralAfricanRepublic,
    chad,
    chile,
    china,
    colombia,
    comoros,
    congoDemocraticRepublic,
    congoRepublic,
    costaRica,
    coteDIvoire,
    croatia,
    cuba,
    cyprus,
    czechRepublic,
    denmark,
    djibouti,
    dominica,
    dominicanRepublic,
    eastTimor,
    ecuador,
    egypt,
    elSalvador,
    equatorialGuinea,
    eritrea,
    estonia,
    northMacedonia,
    eswatini,
    ethiopia,
    fiji,
    finland,
    france,
    gabon,
    gambia,
    georgia,
    germany,
    ghana,
    greece,
    grenada,
    guatemala,
    guinea,
    guineaBissau,
    guyana,
    haiti,
    honduras,
    hungary,
    iceland,
    india,
    indonesia,
    iran,
    iraq,
    ireland,
    israel,
    italy,
    jamaica,
    japan,
    jordan,
    kazakhstan,
    kenya,
    kiribati,
    southKorea,
    northKorea,
    kosovo,
    kuwait,
    kyrgyzstan,
    laos,
    latvia,
    lebanon,
    lesotho,
    liberia,
    libya,
    liechtenstein,
    lithuania,
    luxembourg,
    madagascar,
    malawi,
    malaysia,
    maldives,
    mali,
    malta,
    marshallIslands,
    mauritania,
    mauritius,
    mexico,
    micronesia,
    moldova,
    monaco,
    mongolia,
    montenegro,
    morocco,
    mozambique,
    myanmar,
    namibia,
    nauru,
    nepal,
    netherlands,
    newZealand,
    nicaragua,
    niger,
    nigeria,
    norway,
    oman,
    pakistan,
    palau,
    panama,
    papuaNewGuinea,
    paraguay,
    peru,
    philippines,
    poland,
    portugal,
    qatar,
    romania,
    russia,
    rwanda,
    saintKittsAndNevis,
    saintLucia,
    saintVincentAndTheGrenadines,
    samoa,
    sanMarino,
    saoTomeAndPrincipe,
    saudiArabia,
    senegal,
    serbia,
    seychelles,
    sierraLeone,
    singapore,
    slovakia,
    slovenia,
    solomonIslands,
    somalia,
    southAfrica,
    spain,
    sriLanka,
    sudan,
    suriname,
    sweden,
    switzerland,
    syria,
    taiwan,
    tajikistan,
    tanzania,
    thailand,
    togo,
    tonga,
    trinidadAndTobago,
    tunisia,
    turkey,
    turkmenistan,
    tuvalu,
    uganda,
    ukraine,
    unitedArabEmirates,
    unitedKingdom,
    unitedStates,
    uruguay,
    uzbekistan,
    vanuatu,
    vaticanCity,
    venezuela,
    vietnam,
    yemen,
    zambia,
    zimbabwe,
  ];

  static const Country afghanistan = _afghanistan;
  static const Country albania = _albania;
  static const Country algeria = _algeria;
  static const Country andorra = _andorra;
  static const Country angola = _angola;
  static const Country antiguaAndBarbuda = _antiguaAndBarbuda;
  static const Country argentina = _argentina;
  static const Country armenia = _armenia;
  static const Country australia = _australia;
  static const Country austria = _austria;
  static const Country azerbaijan = _azerbaijan;
  static const Country bahamas = _bahamas;
  static const Country bahrain = _bahrain;
  static const Country bangladesh = _bangladesh;
  static const Country barbados = _barbados;
  static const Country belarus = _belarus;
  static const Country belgium = _belgium;
  static const Country belize = _belize;
  static const Country benin = _benin;
  static const Country bhutan = _bhutan;
  static const Country bolivia = _bolivia;
  static const Country bosniaAndHerzegovina = _bosniaAndHerzegovina;
  static const Country botswana = _botswana;
  static const Country brazil = _brazil;
  static const Country brunei = _brunei;
  static const Country bulgaria = _bulgaria;
  static const Country burkinaFaso = _burkinaFaso;
  static const Country burundi = _burundi;
  static const Country cambodia = _cambodia;
  static const Country cameroon = _cameroon;
  static const Country canada = _canada;
  static const Country capeVerde = _capeVerde;
  static const Country centralAfricanRepublic = _centralAfricanRepublic;
  static const Country chad = _chad;
  static const Country chile = _chile;
  static const Country china = _china;
  static const Country colombia = _colombia;
  static const Country comoros = _comoros;
  static const Country congoDemocraticRepublic = _congoDemocraticRepublic;
  static const Country congoRepublic = _congoRepublic;
  static const Country costaRica = _costaRica;
  static const Country coteDIvoire = _coteDIvoire;
  static const Country croatia = _croatia;
  static const Country cuba = _cuba;
  static const Country cyprus = _cyprus;
  static const Country czechRepublic = _czechRepublic;
  static const Country denmark = _denmark;
  static const Country djibouti = _djibouti;
  static const Country dominica = _dominica;
  static const Country dominicanRepublic = _dominicanRepublic;
  static const Country eastTimor = _eastTimor;
  static const Country ecuador = _ecuador;
  static const Country egypt = _egypt;
  static const Country elSalvador = _elSalvador;
  static const Country equatorialGuinea = _equatorialGuinea;
  static const Country eritrea = _eritrea;
  static const Country estonia = _estonia;
  static const Country northMacedonia = _macedonia;
  static const Country eswatini = _swaziland;
  static const Country ethiopia = _ethiopia;
  static const Country fiji = _fiji;
  static const Country finland = _finland;
  static const Country france = _france;
  static const Country gabon = _gabon;
  static const Country gambia = _gambia;
  static const Country georgia = _georgia;
  static const Country germany = _germany;
  static const Country ghana = _ghana;
  static const Country greece = _greece;
  static const Country grenada = _grenada;
  static const Country guatemala = _guatemala;
  static const Country guinea = _guinea;
  static const Country guineaBissau = _guineaBissau;
  static const Country guyana = _guyana;
  static const Country haiti = _haiti;
  static const Country honduras = _honduras;
  static const Country hungary = _hungary;
  static const Country iceland = _iceland;
  static const Country india = _india;
  static const Country indonesia = _indonesia;
  static const Country iran = _iran;
  static const Country iraq = _iraq;
  static const Country ireland = _ireland;
  static const Country israel = _israel;
  static const Country italy = _italy;
  static const Country jamaica = _jamaica;
  static const Country japan = _japan;
  static const Country jordan = _jordan;
  static const Country kazakhstan = _kazakhstan;
  static const Country kenya = _kenya;
  static const Country kiribati = _kiribati;
  static const Country southKorea = _southKorea;
  static const Country northKorea = _northKorea;
  static const Country kosovo = _kosovo;
  static const Country kuwait = _kuwait;
  static const Country kyrgyzstan = _kyrgyzstan;
  static const Country laos = _laos;
  static const Country latvia = _latvia;
  static const Country lebanon = _lebanon;
  static const Country lesotho = _lesotho;
  static const Country liberia = _liberia;
  static const Country libya = _libya;
  static const Country liechtenstein = _liechtenstein;
  static const Country lithuania = _lithuania;
  static const Country luxembourg = _luxembourg;
  static const Country madagascar = _madagascar;
  static const Country malawi = _malawi;
  static const Country malaysia = _malaysia;
  static const Country maldives = _maldives;
  static const Country mali = _mali;
  static const Country malta = _malta;
  static const Country marshallIslands = _marshallIslands;
  static const Country mauritania = _mauritania;
  static const Country mauritius = _mauritius;
  static const Country mexico = _mexico;
  static const Country micronesia = _micronesia;
  static const Country moldova = _moldova;
  static const Country monaco = _monaco;
  static const Country mongolia = _mongolia;
  static const Country montenegro = _montenegro;
  static const Country morocco = _morocco;
  static const Country mozambique = _mozambique;
  static const Country myanmar = _myanmar;
  static const Country namibia = _namibia;
  static const Country nauru = _nauru;
  static const Country nepal = _nepal;
  static const Country netherlands = _netherlands;
  static const Country newZealand = _newZealand;
  static const Country nicaragua = _nicaragua;
  static const Country niger = _niger;
  static const Country nigeria = _nigeria;
  static const Country norway = _norway;
  static const Country oman = _oman;
  static const Country pakistan = _pakistan;
  static const Country palau = _palau;
  static const Country panama = _panama;
  static const Country papuaNewGuinea = _papuaNewGuinea;
  static const Country paraguay = _paraguay;
  static const Country peru = _peru;
  static const Country philippines = _philippines;
  static const Country poland = _poland;
  static const Country portugal = _portugal;
  static const Country qatar = _qatar;
  static const Country romania = _romania;
  static const Country russia = _russia;
  static const Country rwanda = _rwanda;
  static const Country saintKittsAndNevis = _saintKittsAndNevis;
  static const Country saintLucia = _saintLucia;
  static const Country saintVincentAndTheGrenadines =
      _saintVincentAndTheGrenadines;
  static const Country samoa = _samoa;
  static const Country sanMarino = _sanMarino;
  static const Country saoTomeAndPrincipe = _saoTomeAndPrincipe;
  static const Country saudiArabia = _saudiArabia;
  static const Country senegal = _senegal;
  static const Country serbia = _serbia;
  static const Country seychelles = _seychelles;
  static const Country sierraLeone = _sierraLeone;
  static const Country singapore = _singapore;
  static const Country slovakia = _slovakia;
  static const Country slovenia = _slovenia;
  static const Country solomonIslands = _solomonIslands;
  static const Country somalia = _somalia;
  static const Country southAfrica = _southAfrica;
  static const Country spain = _spain;
  static const Country sriLanka = _sriLanka;
  static const Country sudan = _sudan;
  static const Country suriname = _suriname;
  static const Country sweden = _sweden;
  static const Country switzerland = _switzerland;
  static const Country syria = _syria;
  static const Country taiwan = _taiwan;
  static const Country tajikistan = _tajikistan;
  static const Country tanzania = _tanzania;
  static const Country thailand = _thailand;
  static const Country togo = _togo;
  static const Country tonga = _tonga;
  static const Country trinidadAndTobago = _trinidadAndTobago;
  static const Country tunisia = _tunisia;
  static const Country turkey = _turkey;
  static const Country turkmenistan = _turkmenistan;
  static const Country tuvalu = _tuvalu;
  static const Country uganda = _uganda;
  static const Country ukraine = _ukraine;
  static const Country unitedArabEmirates = _unitedArabEmirates;
  static const Country unitedKingdom = _unitedKingdom;
  static const Country unitedStates = _unitedStates;
  static const Country uruguay = _uruguay;
  static const Country uzbekistan = _uzbekistan;
  static const Country vanuatu = _vanuatu;
  static const Country vaticanCity = _vaticanCity;
  static const Country venezuela = _venezuela;
  static const Country vietnam = _vietnam;
  static const Country yemen = _yemen;
  static const Country zambia = _zambia;
  static const Country zimbabwe = _zimbabwe;

  /// Returns a copy with overridden fields.
  Country copyWith({
    String? name,
    String? alpha2,
    String? alpha3,
    String? flagEmoji,
    String? flagImagePath,
    int? dialCode,
    int? minLength,
    int? maxLength,
  }) {
    return Country(
      name: name ?? this.name,
      alpha2: alpha2 ?? this.alpha2,
      alpha3: alpha3 ?? this.alpha3,
      flagEmoji: flagEmoji ?? this.flagEmoji,
      flagImagePath: flagImagePath ?? this.flagImagePath,
      dialCode: dialCode ?? this.dialCode,
      minLength: minLength ?? this.minLength,
      maxLength: maxLength ?? this.maxLength,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Country &&
            other.name == name &&
            other.alpha2 == alpha2 &&
            other.alpha3 == alpha3 &&
            other.flagEmoji == flagEmoji &&
            other.flagImagePath == flagImagePath &&
            other.dialCode == dialCode &&
            other.minLength == minLength &&
            other.maxLength == maxLength;
  }

  @override
  int get hashCode => Object.hash(
    name,
    alpha2,
    alpha3,
    flagEmoji,
    flagImagePath,
    dialCode,
    minLength,
    maxLength,
  );

  @override
  String toString() => 'Country($name, +$dialCode)';
}
