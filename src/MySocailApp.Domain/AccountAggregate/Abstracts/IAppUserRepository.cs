﻿using MySocailApp.Domain.AppUserAggregate.Entities;

namespace MySocailApp.Domain.AccountAggregate.Abstracts
{
    public interface IAppUserRepository
    {
        Task CreateAsync(AppUser user, CancellationToken cancellationToken);
        Task<AppUser> GetByIdAsync(int id, CancellationToken cancellationToken);
        Task<AppUser> GetWithAllAsync(int id, CancellationToken cancellationToken);
    }
}
