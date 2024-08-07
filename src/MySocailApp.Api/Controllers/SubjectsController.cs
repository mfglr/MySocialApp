﻿using MediatR;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MySocailApp.Api.Filters;
using MySocailApp.Application.Queries.SubjectAggregate;
using MySocailApp.Application.Queries.SubjectAggregate.GetByExamId;

namespace MySocailApp.Api.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    [Authorize(Roles = "user", AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    [ServiceFilter(typeof(CheckAccountFilterAttribute))]
    [ServiceFilter(typeof(CheckEmailConfirmationFilterAttribute))]
    public class SubjectsController(IMediator mediator) : ControllerBase
    {
        private readonly IMediator _mediator = mediator;

        [HttpGet("{examId}")]
        public async Task<List<SubjectResponseDto>> GetByExamId(int examId,CancellationToken cancellationToken)
            => await _mediator.Send(new GetSubjectsByExamIdDto(examId), cancellationToken);
    }
}
