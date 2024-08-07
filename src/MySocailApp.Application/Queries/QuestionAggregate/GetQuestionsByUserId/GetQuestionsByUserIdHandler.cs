﻿using AutoMapper;
using MediatR;
using MySocailApp.Application.Queries.QuestionAggregate.Get;
using MySocailApp.Domain.AppUserAggregate.Exceptions;
using MySocailApp.Domain.QuestionAggregate.Interfaces;

namespace MySocailApp.Application.Queries.QuestionAggregate.GetQuestions
{
    public class GetQuestionsByUserIdHandler(IQuestionReadRepository repository, IMapper mapper) : IRequestHandler<GetQuestionsByUserIdDto, List<QuestionResponseDto>>
    {
        private readonly IQuestionReadRepository _repository = repository;
        private readonly IMapper _mapper = mapper;

        public async Task<List<QuestionResponseDto>> Handle(GetQuestionsByUserIdDto request, CancellationToken cancellationToken)
        {
            var questions = 
                await _repository.GetByUserIdAsync(request.UserId, request.LastValue, cancellationToken) ?? 
                throw new UserIsNotFoundException();
            return _mapper.Map<List<QuestionResponseDto>>(questions);
        }
    }
}
