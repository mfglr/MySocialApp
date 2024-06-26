﻿using MediatR;
using MySocailApp.Application.Services;
using MySocailApp.Domain.AppUserAggregate;
using MySocailApp.Domain.AppUserAggregate.Exceptions;

namespace MySocailApp.Application.Commands.UserAggregate.Block
{
    public class BlockHandler(IAppUserRepository userRepository, IAccessTokenReader accessTokenReader, IUnitOfWork unitOfWork) : IRequestHandler<BlockDto>
    {
        private readonly IAppUserRepository _userRepository = userRepository;
        private readonly IAccessTokenReader _accessTokenReader = accessTokenReader;
        private readonly IUnitOfWork _unitOfWork = unitOfWork;

        public async Task Handle(BlockDto request, CancellationToken cancellationToken)
        {
            string userId = _accessTokenReader.GetRequiredAccountId();

            var userToBlock = 
                await _userRepository.GetWithAllAsync(request.BlockedId,userId,cancellationToken) ??
                throw new UserIsNotFoundException();
            userToBlock.Block(userId);

            await _unitOfWork.CommitAsync(cancellationToken);
        }
    }
}
