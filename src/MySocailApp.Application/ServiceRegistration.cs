﻿using FluentValidation;
using MediatR;
using Microsoft.Extensions.DependencyInjection;
using MySocailApp.Application.ApplicationServices;
using MySocailApp.Application.Mappers;
using MySocailApp.Application.PipelineBehaviours;
using System.Reflection;

namespace MySocailApp.Application
{
    public static class ServiceRegistration
    {
        public static IServiceCollection AddApplicationServices(this IServiceCollection services)
        {
            var assembly = Assembly.GetExecutingAssembly();

            return services
                .AddAutoMapper(cfg =>
                {
                    var sp = services.BuildServiceProvider();
                    var reader = sp.GetRequiredService<IAccessTokenReader>();

                    cfg.AddProfile(new UserMappers(reader));
                    cfg.AddProfile(new QuestionMappers(reader));
                    cfg.AddProfile(new SolutionMappers(reader));
                    cfg.AddProfile(new CommentMappers(reader));
                })
                .AddAutoMapper(assembly)
                .AddMediatR(x => x.RegisterServicesFromAssembly(assembly))
                .AddTransient(typeof(IPipelineBehavior<,>),typeof(ValidationPipelineBehaviour<,>))
                .AddTransient(typeof(IPipelineBehavior<,>), typeof(DomainEventsPublicationPipelineBehaviour<,>))
                .AddValidatorsFromAssembly(assembly);
        }
    }
}
