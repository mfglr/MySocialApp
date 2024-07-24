﻿using MySocailApp.Core;
using MySocailApp.Domain.AppUserAggregate;
using MySocailApp.Domain.ExamAggregate;
using MySocailApp.Domain.QuestionAggregate.Excpetions;
using MySocailApp.Domain.QuestionAggregate.ValueObjects;
using MySocailApp.Domain.QuestionCommentAggregate.Entities;
using MySocailApp.Domain.SolutionAggregate.Entities;
using MySocailApp.Domain.SubjectAggregate;

namespace MySocailApp.Domain.QuestionAggregate.Entities
{
    public class Question() : IAggregateRoot
    {
        public int Id { get; private set; }
        public DateTime CreatedAt { get; private set; }
        public DateTime? UpdatedAt { get; private set; }
        public int ExamId { get; private set; }
        public int SubjectId { get; private set; }
        public int AppUserId { get; private set; }
        public string? Content { get; private set; }
        public QuestionState State { get; private set; }

        private readonly List<QuestionImage> _images = [];
        public IReadOnlyCollection<QuestionImage> Images => _images;
        public bool HasBlobName(string blobName) => _images.Any(x => x.BlobName == blobName);

        private readonly List<QuestionTopic> _topics = [];
        public IReadOnlyCollection<QuestionTopic> Topics => _topics;
        internal void AddNewTopics(IEnumerable<int> topics)
        {
            if (topics.Count() > 3)
                throw new TooManyTopicsException();
            _topics.Clear();
            _topics.AddRange(topics.Select(topicId => QuestionTopic.Create(Id, topicId)));
        }

        internal void Create(int appUserId, string? content, int examId, int subjectId, IEnumerable<int> topics, IEnumerable<QuestionImage> images)
        {
            if (!images.Any())
                throw new QuestionImageIsRequiredException();

            if (topics.Count() > 3)
                throw new TooManyTopicsException();
            
            if (images.Count() > 5)
                throw new TooManyQuestionImagesException();

            AppUserId = appUserId;
            Content = content;
            ExamId = examId;
            SubjectId = subjectId;
            State = QuestionState.NotSolved;
            CreatedAt = DateTime.UtcNow;
            _topics.AddRange(topics.Select(topicId => QuestionTopic.Create(Id, topicId)));
            _images.AddRange(images);
        }
        public void MarkAsSolved()
        {
            State = QuestionState.Solved;
            UpdatedAt = DateTime.UtcNow;
        }

        private readonly List<QuestionUserLike> _likes = [];
        public IReadOnlyList<QuestionUserLike> Likes => _likes;
        public void Like(int userId)
        {
            var index = _likes.FindIndex(x => x.AppUserId == userId);
            if (index != -1)
                _likes.RemoveAt(index);
            _likes.Add(QuestionUserLike.Create(Id, userId));
        }
        public void Dislike(int userId)
        {
            var index = _likes.FindIndex(x => x.AppUserId == userId);
            if (index != -1)
                _likes.RemoveAt(index);
        }

        public Exam Exam { get; }
        public Subject Subject { get; }
        public AppUser AppUser { get; }
        public IReadOnlyList<Solution> Solutions { get; }
        public IReadOnlyCollection<QuestionComment> Comments { get; }

    }
}
