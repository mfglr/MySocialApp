﻿using MediatR;
using MySocailApp.Application.Services;
using MySocailApp.Domain.AppUserAggregate;
using MySocailApp.Domain.AppUserAggregate.Exceptions;

namespace MySocailApp.Application.Commands.UserAggregate.Unblock
{
    public class UnblockHandler(IAppUserRepository userRepository, IUnitOfWork unitOfWork, IAccessTokenReader accessTokenReader) : IRequestHandler<UnblockDto>
    {
        private readonly IAppUserRepository _userRepository = userRepository;
        private readonly IUnitOfWork _unitOfWork = unitOfWork;
        private readonly IAccessTokenReader _accessTokenReader = accessTokenReader;

        public async Task Handle(UnblockDto request, CancellationToken cancellationToken)
        {
            var userId = _accessTokenReader.GetRequiredAccountId();
            var user = 
                await _userRepository.GetWithBlocker(request.UserId, userId,cancellationToken) ?? 
                throw new UserIsNotFoundException();

            user.Unblock(userId);
            await _unitOfWork.CommitAsync(cancellationToken);
        }
    }
}
