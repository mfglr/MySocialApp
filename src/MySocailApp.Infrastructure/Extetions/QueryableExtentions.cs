﻿using Microsoft.EntityFrameworkCore;
using MySocailApp.Core;
using MySocailApp.Domain.CommentAggregate.Entities;
using MySocailApp.Domain.QuestionAggregate.Entities;

namespace MySocailApp.Infrastructure.Extetions
{
    public static class QueryableExtentions
    {
        public static IQueryable<T> ToPage<T>(this IQueryable<T> query, int? lastId, int take) where T : IAggregateRoot
            => query
                .Where(x => lastId == null || x.Id < lastId)
                .OrderByDescending(x => x.Id)
                .Take(take);

        public static IQueryable<Question> IncludeForQuestion(this IQueryable<Question> query)
            => query
                .Include(x => x.Exam)
                .Include(x => x.Subject)
                .Include(x => x.Images)
                .Include(x => x.Topics)
                .ThenInclude(x => x.Topic)
                .Include(x => x.AppUser)
                .ThenInclude(x => x.Account)
                .Include(x => x.Likes)
                .Include(x => x.Solutions)
                .Include(x => x.Comments);

        public static IQueryable<Comment> IncludeForQuestionComment(this IQueryable<Comment> query)
            => query
                .Include(x => x.AppUser)
                .ThenInclude(x => x.Account)
                .Include(x => x.Likes)
                .Include(x => x.Children)
                .Include(x => x.Tags)
                .ThenInclude(x => x.AppUser)
                .ThenInclude(x => x.Account);

    }
}
