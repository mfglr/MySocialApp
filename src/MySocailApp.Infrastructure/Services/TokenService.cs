﻿using Microsoft.AspNetCore.Identity;
using Microsoft.IdentityModel.Tokens;
using MySocailApp.Application.Configurations;
using MySocailApp.Application.Services;
using MySocailApp.Domain.AccountAggregate;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;

namespace MySocailApp.Infrastructure.Services
{
    public class TokenService(ITokenProviderOptions tokenConfiguration, SigningCredentials signingCredentials, JwtSecurityTokenHandler jwtSecurityTokenHandler, UserManager<Account> userManager) : ITokenService
    {
        private readonly ITokenProviderOptions _tokenConfiguration = tokenConfiguration;
        private readonly UserManager<Account> _userManager = userManager;
        private readonly SigningCredentials _signingCredentials = signingCredentials;
        private readonly JwtSecurityTokenHandler _jwtSecurityTokenHandler = jwtSecurityTokenHandler;
        private const string _purpose = "RefreshToken";

        private List<Claim> GetClaims(Account account, List<string> roles)
        {
            var claims = new List<Claim>()
            {
                new (JwtRegisteredClaimNames.Jti,Guid.NewGuid().ToString()),
                new (ClaimTypes.NameIdentifier, account.Id),
                new (ClaimTypes.Name,account.UserName!),
                new (ClaimTypes.Email,account.Email!),
                new (JwtRegisteredClaimNames.Aud, _tokenConfiguration.Audience)
            };

            foreach (var role in roles)
                claims.Add(new(ClaimTypes.Role, role));

            return claims;
        }

        public async Task<Token> CreateTokenAsync(Account account)
        {
            var expirationDateOfRefreshToken = DateTime.Now.AddMinutes(_tokenConfiguration.RefreshTokenExpiration);
            var expirationDateOfAccessToken = DateTime.Now.AddMinutes(_tokenConfiguration.AccessTokenExpiration);

            string refreshToken = await _userManager.GenerateUserTokenAsync(account, TokenProviders.REFRESH_TOKEN_PROVIDER, _purpose);

            var roles = (await _userManager.GetRolesAsync(account)).ToList();

            JwtSecurityToken jwtSecurityToken = new(
                issuer: _tokenConfiguration.Issuer,
                expires: expirationDateOfAccessToken,
                notBefore: DateTime.Now,
                claims: GetClaims(account, roles),
                signingCredentials: _signingCredentials
            );

            var accessToken = _jwtSecurityTokenHandler.WriteToken(jwtSecurityToken);
            return new(accessToken, expirationDateOfAccessToken, refreshToken, expirationDateOfRefreshToken);
        }

        public async Task<bool> VerifyRefreshToken(Account account, string refreshToken)
        {
            return await _userManager.VerifyUserTokenAsync(
                account,TokenProviders.REFRESH_TOKEN_PROVIDER,_purpose,refreshToken
            );
        }
    }
}
