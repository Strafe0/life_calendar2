// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'week.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Week {

 int get id; int get yearId; DateTime get start; DateTime get end;@JsonKey(name: 'state') WeekTense get tense; WeekAssessment get assessment;@GoalConverter() List<Goal> get goals;@EventConverter() List<Event> get events; String get resume;@PhotoConverter() List<String> get photos;
/// Create a copy of Week
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeekCopyWith<Week> get copyWith => _$WeekCopyWithImpl<Week>(this as Week, _$identity);

  /// Serializes this Week to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Week&&(identical(other.id, id) || other.id == id)&&(identical(other.yearId, yearId) || other.yearId == yearId)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.tense, tense) || other.tense == tense)&&(identical(other.assessment, assessment) || other.assessment == assessment)&&const DeepCollectionEquality().equals(other.goals, goals)&&const DeepCollectionEquality().equals(other.events, events)&&(identical(other.resume, resume) || other.resume == resume)&&const DeepCollectionEquality().equals(other.photos, photos));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,yearId,start,end,tense,assessment,const DeepCollectionEquality().hash(goals),const DeepCollectionEquality().hash(events),resume,const DeepCollectionEquality().hash(photos));

@override
String toString() {
  return 'Week(id: $id, yearId: $yearId, start: $start, end: $end, tense: $tense, assessment: $assessment, goals: $goals, events: $events, resume: $resume, photos: $photos)';
}


}

/// @nodoc
abstract mixin class $WeekCopyWith<$Res>  {
  factory $WeekCopyWith(Week value, $Res Function(Week) _then) = _$WeekCopyWithImpl;
@useResult
$Res call({
 int id, int yearId, DateTime start, DateTime end,@JsonKey(name: 'state') WeekTense tense, WeekAssessment assessment,@GoalConverter() List<Goal> goals,@EventConverter() List<Event> events, String resume,@PhotoConverter() List<String> photos
});




}
/// @nodoc
class _$WeekCopyWithImpl<$Res>
    implements $WeekCopyWith<$Res> {
  _$WeekCopyWithImpl(this._self, this._then);

  final Week _self;
  final $Res Function(Week) _then;

/// Create a copy of Week
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? yearId = null,Object? start = null,Object? end = null,Object? tense = null,Object? assessment = null,Object? goals = null,Object? events = null,Object? resume = null,Object? photos = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,yearId: null == yearId ? _self.yearId : yearId // ignore: cast_nullable_to_non_nullable
as int,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,tense: null == tense ? _self.tense : tense // ignore: cast_nullable_to_non_nullable
as WeekTense,assessment: null == assessment ? _self.assessment : assessment // ignore: cast_nullable_to_non_nullable
as WeekAssessment,goals: null == goals ? _self.goals : goals // ignore: cast_nullable_to_non_nullable
as List<Goal>,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<Event>,resume: null == resume ? _self.resume : resume // ignore: cast_nullable_to_non_nullable
as String,photos: null == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Week implements Week {
  const _Week({required this.id, required this.yearId, required this.start, required this.end, @JsonKey(name: 'state') required this.tense, required this.assessment, @GoalConverter() required final  List<Goal> goals, @EventConverter() required final  List<Event> events, required this.resume, @PhotoConverter() required final  List<String> photos}): _goals = goals,_events = events,_photos = photos;
  factory _Week.fromJson(Map<String, dynamic> json) => _$WeekFromJson(json);

@override final  int id;
@override final  int yearId;
@override final  DateTime start;
@override final  DateTime end;
@override@JsonKey(name: 'state') final  WeekTense tense;
@override final  WeekAssessment assessment;
 final  List<Goal> _goals;
@override@GoalConverter() List<Goal> get goals {
  if (_goals is EqualUnmodifiableListView) return _goals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_goals);
}

 final  List<Event> _events;
@override@EventConverter() List<Event> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}

@override final  String resume;
 final  List<String> _photos;
@override@PhotoConverter() List<String> get photos {
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photos);
}


/// Create a copy of Week
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeekCopyWith<_Week> get copyWith => __$WeekCopyWithImpl<_Week>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeekToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Week&&(identical(other.id, id) || other.id == id)&&(identical(other.yearId, yearId) || other.yearId == yearId)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.tense, tense) || other.tense == tense)&&(identical(other.assessment, assessment) || other.assessment == assessment)&&const DeepCollectionEquality().equals(other._goals, _goals)&&const DeepCollectionEquality().equals(other._events, _events)&&(identical(other.resume, resume) || other.resume == resume)&&const DeepCollectionEquality().equals(other._photos, _photos));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,yearId,start,end,tense,assessment,const DeepCollectionEquality().hash(_goals),const DeepCollectionEquality().hash(_events),resume,const DeepCollectionEquality().hash(_photos));

@override
String toString() {
  return 'Week(id: $id, yearId: $yearId, start: $start, end: $end, tense: $tense, assessment: $assessment, goals: $goals, events: $events, resume: $resume, photos: $photos)';
}


}

/// @nodoc
abstract mixin class _$WeekCopyWith<$Res> implements $WeekCopyWith<$Res> {
  factory _$WeekCopyWith(_Week value, $Res Function(_Week) _then) = __$WeekCopyWithImpl;
@override @useResult
$Res call({
 int id, int yearId, DateTime start, DateTime end,@JsonKey(name: 'state') WeekTense tense, WeekAssessment assessment,@GoalConverter() List<Goal> goals,@EventConverter() List<Event> events, String resume,@PhotoConverter() List<String> photos
});




}
/// @nodoc
class __$WeekCopyWithImpl<$Res>
    implements _$WeekCopyWith<$Res> {
  __$WeekCopyWithImpl(this._self, this._then);

  final _Week _self;
  final $Res Function(_Week) _then;

/// Create a copy of Week
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? yearId = null,Object? start = null,Object? end = null,Object? tense = null,Object? assessment = null,Object? goals = null,Object? events = null,Object? resume = null,Object? photos = null,}) {
  return _then(_Week(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,yearId: null == yearId ? _self.yearId : yearId // ignore: cast_nullable_to_non_nullable
as int,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,tense: null == tense ? _self.tense : tense // ignore: cast_nullable_to_non_nullable
as WeekTense,assessment: null == assessment ? _self.assessment : assessment // ignore: cast_nullable_to_non_nullable
as WeekAssessment,goals: null == goals ? _self._goals : goals // ignore: cast_nullable_to_non_nullable
as List<Goal>,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<Event>,resume: null == resume ? _self.resume : resume // ignore: cast_nullable_to_non_nullable
as String,photos: null == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
