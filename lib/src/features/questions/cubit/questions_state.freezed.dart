// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'questions_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$QuestionsState {
  List<Question> get questions => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  Topic get currentTopic => throw _privateConstructorUsedError;
  int get selectedTopicIndex => throw _privateConstructorUsedError;
  Map<Topic, List<Question>> get questionsByTopic =>
      throw _privateConstructorUsedError;

  /// Create a copy of QuestionsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuestionsStateCopyWith<QuestionsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionsStateCopyWith<$Res> {
  factory $QuestionsStateCopyWith(
          QuestionsState value, $Res Function(QuestionsState) then) =
      _$QuestionsStateCopyWithImpl<$Res, QuestionsState>;
  @useResult
  $Res call(
      {List<Question> questions,
      bool isLoading,
      Topic currentTopic,
      int selectedTopicIndex,
      Map<Topic, List<Question>> questionsByTopic});
}

/// @nodoc
class _$QuestionsStateCopyWithImpl<$Res, $Val extends QuestionsState>
    implements $QuestionsStateCopyWith<$Res> {
  _$QuestionsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuestionsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questions = null,
    Object? isLoading = null,
    Object? currentTopic = null,
    Object? selectedTopicIndex = null,
    Object? questionsByTopic = null,
  }) {
    return _then(_value.copyWith(
      questions: null == questions
          ? _value.questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<Question>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      currentTopic: null == currentTopic
          ? _value.currentTopic
          : currentTopic // ignore: cast_nullable_to_non_nullable
              as Topic,
      selectedTopicIndex: null == selectedTopicIndex
          ? _value.selectedTopicIndex
          : selectedTopicIndex // ignore: cast_nullable_to_non_nullable
              as int,
      questionsByTopic: null == questionsByTopic
          ? _value.questionsByTopic
          : questionsByTopic // ignore: cast_nullable_to_non_nullable
              as Map<Topic, List<Question>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuestionsStateImplCopyWith<$Res>
    implements $QuestionsStateCopyWith<$Res> {
  factory _$$QuestionsStateImplCopyWith(_$QuestionsStateImpl value,
          $Res Function(_$QuestionsStateImpl) then) =
      __$$QuestionsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Question> questions,
      bool isLoading,
      Topic currentTopic,
      int selectedTopicIndex,
      Map<Topic, List<Question>> questionsByTopic});
}

/// @nodoc
class __$$QuestionsStateImplCopyWithImpl<$Res>
    extends _$QuestionsStateCopyWithImpl<$Res, _$QuestionsStateImpl>
    implements _$$QuestionsStateImplCopyWith<$Res> {
  __$$QuestionsStateImplCopyWithImpl(
      _$QuestionsStateImpl _value, $Res Function(_$QuestionsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuestionsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questions = null,
    Object? isLoading = null,
    Object? currentTopic = null,
    Object? selectedTopicIndex = null,
    Object? questionsByTopic = null,
  }) {
    return _then(_$QuestionsStateImpl(
      questions: null == questions
          ? _value._questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<Question>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      currentTopic: null == currentTopic
          ? _value.currentTopic
          : currentTopic // ignore: cast_nullable_to_non_nullable
              as Topic,
      selectedTopicIndex: null == selectedTopicIndex
          ? _value.selectedTopicIndex
          : selectedTopicIndex // ignore: cast_nullable_to_non_nullable
              as int,
      questionsByTopic: null == questionsByTopic
          ? _value._questionsByTopic
          : questionsByTopic // ignore: cast_nullable_to_non_nullable
              as Map<Topic, List<Question>>,
    ));
  }
}

/// @nodoc

class _$QuestionsStateImpl implements _QuestionsState {
  const _$QuestionsStateImpl(
      {final List<Question> questions = const [],
      this.isLoading = true,
      this.currentTopic = Topic.novo,
      this.selectedTopicIndex = 0,
      final Map<Topic, List<Question>> questionsByTopic = const {}})
      : _questions = questions,
        _questionsByTopic = questionsByTopic;

  final List<Question> _questions;
  @override
  @JsonKey()
  List<Question> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final Topic currentTopic;
  @override
  @JsonKey()
  final int selectedTopicIndex;
  final Map<Topic, List<Question>> _questionsByTopic;
  @override
  @JsonKey()
  Map<Topic, List<Question>> get questionsByTopic {
    if (_questionsByTopic is EqualUnmodifiableMapView) return _questionsByTopic;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_questionsByTopic);
  }

  @override
  String toString() {
    return 'QuestionsState(questions: $questions, isLoading: $isLoading, currentTopic: $currentTopic, selectedTopicIndex: $selectedTopicIndex, questionsByTopic: $questionsByTopic)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestionsStateImpl &&
            const DeepCollectionEquality()
                .equals(other._questions, _questions) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.currentTopic, currentTopic) ||
                other.currentTopic == currentTopic) &&
            (identical(other.selectedTopicIndex, selectedTopicIndex) ||
                other.selectedTopicIndex == selectedTopicIndex) &&
            const DeepCollectionEquality()
                .equals(other._questionsByTopic, _questionsByTopic));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_questions),
      isLoading,
      currentTopic,
      selectedTopicIndex,
      const DeepCollectionEquality().hash(_questionsByTopic));

  /// Create a copy of QuestionsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestionsStateImplCopyWith<_$QuestionsStateImpl> get copyWith =>
      __$$QuestionsStateImplCopyWithImpl<_$QuestionsStateImpl>(
          this, _$identity);
}

abstract class _QuestionsState implements QuestionsState {
  const factory _QuestionsState(
          {final List<Question> questions,
          final bool isLoading,
          final Topic currentTopic,
          final int selectedTopicIndex,
          final Map<Topic, List<Question>> questionsByTopic}) =
      _$QuestionsStateImpl;

  @override
  List<Question> get questions;
  @override
  bool get isLoading;
  @override
  Topic get currentTopic;
  @override
  int get selectedTopicIndex;
  @override
  Map<Topic, List<Question>> get questionsByTopic;

  /// Create a copy of QuestionsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuestionsStateImplCopyWith<_$QuestionsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
