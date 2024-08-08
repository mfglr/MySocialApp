﻿using MediatR;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MySocailApp.Api.Filters;
using MySocailApp.Application.Commands.QuestionAggregate.CreateQuestion;
using MySocailApp.Application.Commands.QuestionAggregate.DislikeQuestion;
using MySocailApp.Application.Commands.QuestionAggregate.LikeQuestion;
using MySocailApp.Application.Queries.QuestionAggregate;
using MySocailApp.Application.Queries.QuestionAggregate.GerAllQuestions;
using MySocailApp.Application.Queries.QuestionAggregate.Get;
using MySocailApp.Application.Queries.QuestionAggregate.GetQuestionById;
using MySocailApp.Application.Queries.QuestionAggregate.GetQuestionImage;
using MySocailApp.Application.Queries.QuestionAggregate.GetQuestionsByExamId;
using MySocailApp.Application.Queries.QuestionAggregate.GetQuestionsBySubjectId;
using MySocailApp.Application.Queries.QuestionAggregate.GetQuestionsByTopicId;

namespace MySocailApp.Api.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    [Authorize(Roles = "user", AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    [ServiceFilter(typeof(CheckAccountFilterAttribute))]
    [ServiceFilter(typeof(CheckEmailConfirmationFilterAttribute))]
    public class QuestionsController(IMediator mediator) : ControllerBase
    {
        private readonly IMediator _mediator = mediator;

        [HttpPost]
        public async Task<QuestionResponseDto> Create([FromForm]string? content, [FromForm]int examId, [FromForm]int subjectId, [FromForm]string? topicIds, [FromForm]IFormFileCollection images, CancellationToken cancellationToken)
            => await _mediator.Send(new CreateQuestionDto(content, examId, subjectId, topicIds, images), cancellationToken);

        [HttpPut]
        public async Task Like(LikeQuestionDto request,CancellationToken cancellationToken)
            => await _mediator.Send(request, cancellationToken);

        [HttpPut]
        public async Task Dislike(DislikeQuestionDto request, CancellationToken cancellationToken)
            => await _mediator.Send(request, cancellationToken);

        [HttpGet("{questionId}/{blobName}")]
        public async Task<FileResult> GetImage(int questionId, string blobName, CancellationToken cancellationToken)
           => File(
               await _mediator.Send(new GetQuestionImageDto(questionId, blobName), cancellationToken),
               "application/octet-stream"
            );

        [HttpGet("{id}")]
        public async Task<QuestionResponseDto> GetQuestionById(int id, CancellationToken cancellationToken)
           => await _mediator.Send(new GetQuestionByIdDto(id), cancellationToken);

        [HttpGet("{userId}")]
        public async Task<List<QuestionResponseDto>> GetQuestionsByUserId(int userId, [FromQuery]int? lastValue, [FromQuery]int? take, CancellationToken cancellationToken)
           => await _mediator.Send(new GetQuestionsByUserIdDto(userId, lastValue, take), cancellationToken);

        [HttpGet("{topicId}")]
        public async Task<List<QuestionResponseDto>> GetQuestionsByTopicId(int topicId,[FromQuery]int? lastValue, [FromQuery] int? take, CancellationToken cancellationToken)
           => await _mediator.Send(new GetQuestionsByTopicIdDto(topicId, lastValue, take), cancellationToken);
        
        [HttpGet("{subjectId}")]
        public async Task<List<QuestionResponseDto>> GetQuestionsBySubjectId(int subjectId, [FromQuery]int? lastValue, [FromQuery] int? take, CancellationToken cancellationToken)
           => await _mediator.Send(new GetQuestionsBySubjectIdDto(subjectId, lastValue, take), cancellationToken);

        [HttpGet("{examId}")]
        public async Task<List<QuestionResponseDto>> GetQuestionsByExamId(int examId, [FromQuery] int? lastValue, [FromQuery] int? take, CancellationToken cancellationToken)
           => await _mediator.Send(new GetQuestionsByExamIdDto(examId, lastValue, take), cancellationToken);

        [HttpGet]
        public async Task<List<QuestionResponseDto>> GetAllQuestions([FromQuery]int? lastValue, [FromQuery] int? take, CancellationToken cancellationToken)
            => await _mediator.Send(new GetAllQuestionsDto(lastValue, take),cancellationToken);
    }
}
