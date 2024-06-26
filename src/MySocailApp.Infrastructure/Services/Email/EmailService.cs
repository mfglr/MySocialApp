﻿using MySocailApp.Application.Services;
using MySocailApp.Domain.AccountAggregate;
using System.Net.Mail;

namespace MySocailApp.Infrastructure.Services.Email
{
    public class EmailService : IEmailService
    {

        private readonly MailMessageFactory _messageFactory;
        private readonly SmtpClient _smtpClient;

        public EmailService(MailMessageFactory messageFactory, SmtpClient smtpClient)
        {
            _messageFactory = messageFactory;
            _smtpClient = smtpClient;
        }

        public async Task SendEmailConfirmationMail(
            string token,string id,string userName,string email,CancellationToken cancellationToken = default
        )
        {
            var mailMessagge = await _messageFactory.CreateEmailConfirmationMailMessageAsync(
                token,id, userName, email, cancellationToken
            );
            await _smtpClient.SendMailAsync(mailMessagge, cancellationToken);
        }

        public async Task SendEmailConfirmationByTokenMail(
            EmailConfirmationToken token, string userName, string email, CancellationToken cancellationToken = default
        )
        {
            var mailMessagge = await _messageFactory.CreateEmailConfirmationByTokenMailMessageAsync(
                token.Token, userName, email, cancellationToken
            );
            await _smtpClient.SendMailAsync(mailMessagge, cancellationToken);
        }
    }
}
