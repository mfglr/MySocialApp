﻿using MediatR;
using MySocailApp.Application.Services;
using MySocailApp.Domain.AppUserAggregate;
using MySocailApp.Domain.AppUserAggregate.Exceptions;

namespace MySocailApp.Application.Commands.UserAggregate.UpdateName
{
    public class UpdateNameHandler(IAppUserRepository userRepository, IAccessTokenReader accessTokenReader, IUnitOfWork unitOfWork) : IRequestHandler<UpdateNameDto>
    {
        private readonly IAppUserRepository _userRepository = userRepository;
        private readonly IAccessTokenReader _accessTokenReader = accessTokenReader;
        private readonly IUnitOfWork _unitOfWork = unitOfWork;

        public async Task Handle(UpdateNameDto request, CancellationToken cancellationToken)
        {
            var userId = _accessTokenReader.GetRequiredAccountId();
            var user =
                await _userRepository.GetByIdAsync(userId, cancellationToken) ??
                throw new UserIsNotFoundException();
            user.UpdateName(request.Name);
            await _unitOfWork.CommitAsync(cancellationToken);
        }
    }
}
