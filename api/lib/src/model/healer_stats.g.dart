// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'healer_stats.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HealerStats extends HealerStats {
  @override
  final String id;
  @override
  final int totalEvents;
  @override
  final int totalDuration;
  @override
  final int totalEventsFaceToFace;
  @override
  final int totalDurationFaceToFace;
  @override
  final String? street;
  @override
  final String? street2;
  @override
  final String city;
  @override
  final String zipCode;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String email;
  @override
  final String? mobile;
  @override
  final String job;

  factory _$HealerStats([void Function(HealerStatsBuilder)? updates]) =>
      (new HealerStatsBuilder()..update(updates)).build();

  _$HealerStats._(
      {required this.id,
      required this.totalEvents,
      required this.totalDuration,
      required this.totalEventsFaceToFace,
      required this.totalDurationFaceToFace,
      this.street,
      this.street2,
      required this.city,
      required this.zipCode,
      required this.firstName,
      required this.lastName,
      required this.email,
      this.mobile,
      required this.job})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, 'HealerStats', 'id');
    BuiltValueNullFieldError.checkNotNull(
        totalEvents, 'HealerStats', 'totalEvents');
    BuiltValueNullFieldError.checkNotNull(
        totalDuration, 'HealerStats', 'totalDuration');
    BuiltValueNullFieldError.checkNotNull(
        totalEventsFaceToFace, 'HealerStats', 'totalEventsFaceToFace');
    BuiltValueNullFieldError.checkNotNull(
        totalDurationFaceToFace, 'HealerStats', 'totalDurationFaceToFace');
    BuiltValueNullFieldError.checkNotNull(city, 'HealerStats', 'city');
    BuiltValueNullFieldError.checkNotNull(zipCode, 'HealerStats', 'zipCode');
    BuiltValueNullFieldError.checkNotNull(
        firstName, 'HealerStats', 'firstName');
    BuiltValueNullFieldError.checkNotNull(lastName, 'HealerStats', 'lastName');
    BuiltValueNullFieldError.checkNotNull(email, 'HealerStats', 'email');
    BuiltValueNullFieldError.checkNotNull(job, 'HealerStats', 'job');
  }

  @override
  HealerStats rebuild(void Function(HealerStatsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HealerStatsBuilder toBuilder() => new HealerStatsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HealerStats &&
        id == other.id &&
        totalEvents == other.totalEvents &&
        totalDuration == other.totalDuration &&
        totalEventsFaceToFace == other.totalEventsFaceToFace &&
        totalDurationFaceToFace == other.totalDurationFaceToFace &&
        street == other.street &&
        street2 == other.street2 &&
        city == other.city &&
        zipCode == other.zipCode &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        email == other.email &&
        mobile == other.mobile &&
        job == other.job;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc($jc(0, id.hashCode),
                                                        totalEvents.hashCode),
                                                    totalDuration.hashCode),
                                                totalEventsFaceToFace.hashCode),
                                            totalDurationFaceToFace.hashCode),
                                        street.hashCode),
                                    street2.hashCode),
                                city.hashCode),
                            zipCode.hashCode),
                        firstName.hashCode),
                    lastName.hashCode),
                email.hashCode),
            mobile.hashCode),
        job.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('HealerStats')
          ..add('id', id)
          ..add('totalEvents', totalEvents)
          ..add('totalDuration', totalDuration)
          ..add('totalEventsFaceToFace', totalEventsFaceToFace)
          ..add('totalDurationFaceToFace', totalDurationFaceToFace)
          ..add('street', street)
          ..add('street2', street2)
          ..add('city', city)
          ..add('zipCode', zipCode)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('email', email)
          ..add('mobile', mobile)
          ..add('job', job))
        .toString();
  }
}

class HealerStatsBuilder implements Builder<HealerStats, HealerStatsBuilder> {
  _$HealerStats? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  int? _totalEvents;
  int? get totalEvents => _$this._totalEvents;
  set totalEvents(int? totalEvents) => _$this._totalEvents = totalEvents;

  int? _totalDuration;
  int? get totalDuration => _$this._totalDuration;
  set totalDuration(int? totalDuration) =>
      _$this._totalDuration = totalDuration;

  int? _totalEventsFaceToFace;
  int? get totalEventsFaceToFace => _$this._totalEventsFaceToFace;
  set totalEventsFaceToFace(int? totalEventsFaceToFace) =>
      _$this._totalEventsFaceToFace = totalEventsFaceToFace;

  int? _totalDurationFaceToFace;
  int? get totalDurationFaceToFace => _$this._totalDurationFaceToFace;
  set totalDurationFaceToFace(int? totalDurationFaceToFace) =>
      _$this._totalDurationFaceToFace = totalDurationFaceToFace;

  String? _street;
  String? get street => _$this._street;
  set street(String? street) => _$this._street = street;

  String? _street2;
  String? get street2 => _$this._street2;
  set street2(String? street2) => _$this._street2 = street2;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  String? _zipCode;
  String? get zipCode => _$this._zipCode;
  set zipCode(String? zipCode) => _$this._zipCode = zipCode;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _mobile;
  String? get mobile => _$this._mobile;
  set mobile(String? mobile) => _$this._mobile = mobile;

  String? _job;
  String? get job => _$this._job;
  set job(String? job) => _$this._job = job;

  HealerStatsBuilder() {
    HealerStats._defaults(this);
  }

  HealerStatsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _totalEvents = $v.totalEvents;
      _totalDuration = $v.totalDuration;
      _totalEventsFaceToFace = $v.totalEventsFaceToFace;
      _totalDurationFaceToFace = $v.totalDurationFaceToFace;
      _street = $v.street;
      _street2 = $v.street2;
      _city = $v.city;
      _zipCode = $v.zipCode;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _email = $v.email;
      _mobile = $v.mobile;
      _job = $v.job;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HealerStats other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$HealerStats;
  }

  @override
  void update(void Function(HealerStatsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$HealerStats build() {
    final _$result = _$v ??
        new _$HealerStats._(
            id: BuiltValueNullFieldError.checkNotNull(id, 'HealerStats', 'id'),
            totalEvents: BuiltValueNullFieldError.checkNotNull(
                totalEvents, 'HealerStats', 'totalEvents'),
            totalDuration: BuiltValueNullFieldError.checkNotNull(
                totalDuration, 'HealerStats', 'totalDuration'),
            totalEventsFaceToFace: BuiltValueNullFieldError.checkNotNull(
                totalEventsFaceToFace, 'HealerStats', 'totalEventsFaceToFace'),
            totalDurationFaceToFace: BuiltValueNullFieldError.checkNotNull(
                totalDurationFaceToFace, 'HealerStats', 'totalDurationFaceToFace'),
            street: street,
            street2: street2,
            city: BuiltValueNullFieldError.checkNotNull(
                city, 'HealerStats', 'city'),
            zipCode: BuiltValueNullFieldError.checkNotNull(
                zipCode, 'HealerStats', 'zipCode'),
            firstName: BuiltValueNullFieldError.checkNotNull(
                firstName, 'HealerStats', 'firstName'),
            lastName: BuiltValueNullFieldError.checkNotNull(
                lastName, 'HealerStats', 'lastName'),
            email: BuiltValueNullFieldError.checkNotNull(email, 'HealerStats', 'email'),
            mobile: mobile,
            job: BuiltValueNullFieldError.checkNotNull(job, 'HealerStats', 'job'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
