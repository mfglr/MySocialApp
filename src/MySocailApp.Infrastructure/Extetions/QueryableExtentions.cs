﻿using Microsoft.EntityFrameworkCore;
using MySocailApp.Core;
using MySocailApp.Domain.QuestionAggregate.Entities;

namespace MySocailApp.Infrastructure.Extetions
{
    public static class QueryableExtentions
    {
        public static IQueryable<T> ToPage<T>(this IQueryable<T> query, int? lastId, int take) where T : IPaginable
            => query
                .Where(x => lastId == null || x.PaginatioinPropery < lastId)
                .OrderByDescending(x => x.PaginatioinPropery)
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
                .Include(x => x.Likes);

    }
}