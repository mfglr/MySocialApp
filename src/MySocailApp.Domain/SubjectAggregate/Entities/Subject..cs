﻿using MySocailApp.Core;
using MySocailApp.Domain.ExamAggregate.Entitities;
using MySocailApp.Domain.QuestionAggregate.Entities;
using MySocailApp.Domain.TopicAggregate.Entities;

namespace MySocailApp.Domain.SubjectAggregate.Entities
{
    public class Subject() : IPaginableAggregateRoot
    {
        public int Id { get; private set; }
        public DateTime CreatedAt { get; private set; }
        public DateTime? UpdatedAt { get; private set; }
        public int ExamId { get; private set; }
        public string Name { get; private set; } = null!;

        public void Create(int examId, string name)
        {
            ExamId = examId;
            Name = name;
            CreatedAt = DateTime.UtcNow;
        }

        public IReadOnlyCollection<Topic> Topics { get; } = null!;
        public IReadOnlyCollection<Question> Quesitons { get; } = null!;
        public Exam Exam { get; } = null!;
    }
}
