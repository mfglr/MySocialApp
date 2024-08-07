﻿using MySocailApp.Domain.TopicAggregate.Entities;

namespace MySocailApp.Domain.QuestionAggregate.Entities
{
    public class QuestionTopic
    {
        public int QuestionId { get; private set; }
        public DateTime CreatedAt { get; private set; }
        public int TopicId { get; private set; }
        public Topic Topic { get; }
        public Question Question { get; }


        private QuestionTopic(int questionId, int topicId)
        {
            QuestionId = questionId;
            TopicId = topicId;
        }

        public static QuestionTopic Create(int questionId, int topicId)
            => new(questionId, topicId) { CreatedAt = DateTime.UtcNow };
    }
}
