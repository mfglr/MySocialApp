﻿using MySocailApp.Application.Services;
using MySocailApp.Core;
using MySocailApp.Domain.AccountAggregate.DomainEvents;

namespace MySocailApp.Application.DomainEventConsumers.EmailConfirmationTokenUpdatedDomainEventConsumers
{
    public class SendEmailConfirmationMailOnTokenUpdated(IEmailService emailService) : IDomainEventConsumer<EmailConfirmationtokenUpdatedDomainEvent>
    {
        private readonly IEmailService _emailService = emailService;

        public async Task Handle(EmailConfirmationtokenUpdatedDomainEvent notification, CancellationToken cancellationToken)
        {
            await _emailService.SendEmailConfirmationByTokenMail(
                notification.Account.EmailVerificationToken, 
                notification.Account.UserName!, 
                notification.Account.Email!, 
                cancellationToken
            );
        }
    }
}
