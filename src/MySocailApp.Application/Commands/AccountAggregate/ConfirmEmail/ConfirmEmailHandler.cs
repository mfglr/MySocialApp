﻿using MediatR;
using Microsoft.AspNetCore.Identity;
using MySocailApp.Domain.AccountAggregate.DomainServices;
using MySocailApp.Domain.AccountAggregate.Entities;
using MySocailApp.Domain.AccountAggregate.Exceptions;

namespace MySocailApp.Application.Commands.AccountAggregate.ConfirmEmail
{
    public class ConfirmEmailHandler(UserManager<Account> userManager) : IRequestHandler<ConfirmEmailDto>
    {
        private readonly UserManager<Account> _userManager = userManager;

        public async Task Handle(ConfirmEmailDto request, CancellationToken cancellationToken)
        {
            var account = await _userManager.FindByIdAsync(request.Id) ?? throw new AccountWasNotFoundException();
            await _userManager.ConfirmEmailByEncodedTokenAsync(account, request.Token);
        }
    }
}
