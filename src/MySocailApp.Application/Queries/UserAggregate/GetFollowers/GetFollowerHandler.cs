﻿using AutoMapper;
using MediatR;
using MySocailApp.Application.ApplicationServices;
using MySocailApp.Domain.AppUserAggregate.Interfaces;

namespace MySocailApp.Application.Queries.UserAggregate.GetFollowers
{
    public class GetFollowerHandler(IAppUserReadRepository repository,IAccessTokenReader accessTokenReader,IMapper mapper) : IRequestHandler<GetFollowersDto, List<AppUserResponseDto>>
    {
        private readonly IAppUserReadRepository _repository = repository;
        private readonly IAccessTokenReader _accessTokenReader = accessTokenReader;
        private readonly IMapper _mapper = mapper;

        public async Task<List<AppUserResponseDto>> Handle(GetFollowersDto request, CancellationToken cancellationToken)
        {
            var accountId = _accessTokenReader.GetRequiredAccountId();
            var users = await _repository.GetFollowersByIdAsync(accountId, request.LastValue, cancellationToken);
            return _mapper.Map<List<AppUserResponseDto>>(users);
        }
    }
}
