﻿using Microsoft.AspNetCore.Http;
using MySocailApp.Application.Exceptions;
using MySocailApp.Core.Exceptions;
using System.Net;
using System.Security.Claims;
using System.Text;

namespace MySocailApp.Application.Extentions
{
    public static class HttpContextExtention
    {
        private static void ThrowExceptionIfContextIsNull(HttpContext? context)
        {
            if (context == null) throw new NotAuthorizedException();
        }

        public static string GetRequiredUserId(this HttpContext? context)
        {
            ThrowExceptionIfContextIsNull(context);
            return
                context!.User.Claims.FirstOrDefault(x => x.Type == ClaimTypes.NameIdentifier)?.Value ??
                throw new NotAuthorizedException();
        }

        public static async Task WriteAppExceptionAsync(this HttpContext? context, AppException ex)
        {
            ThrowExceptionIfContextIsNull(context);
            var body = Encoding.ASCII.GetBytes(ex.Message);
            context!.Response.StatusCode = ex.StatusCode;
            context!.Response.ContentType = "application/json";
            await context.Response.Body.WriteAsync(body);
        }

        public static async Task WriteExceptionAsync(this HttpContext? context, Exception ex)
        {
            ThrowExceptionIfContextIsNull(context);
            var body = Encoding.ASCII.GetBytes(ex.Message);
            context!.Response.StatusCode = (int)HttpStatusCode.InternalServerError;
            context!.Response.ContentType = "application/json";
            await context.Response.Body.WriteAsync(body);
        }
    }
}
