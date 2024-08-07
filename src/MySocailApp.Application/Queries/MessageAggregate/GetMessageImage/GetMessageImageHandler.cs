﻿using MediatR;
using MySocailApp.Application.ApplicationServices;
using MySocailApp.Application.ApplicationServices.BlobService;
using MySocailApp.Application.Extentions;
using MySocailApp.Domain.MessageAggregate.Exceptions;
using MySocailApp.Domain.MessageAggregate.Interfaces;

namespace MySocailApp.Application.Queries.MessageAggregate.GetMessageImage
{
    public class GetMessageImageHandler(IMessageReadRepository messageReadRepository, IBlobService blobService, IAccessTokenReader accessTokenReader) : IRequestHandler<GetMessageImageDto, byte[]>
    {
        private readonly IAccessTokenReader _accessTokenReader = accessTokenReader;
        private readonly IMessageReadRepository _messageReadRepository = messageReadRepository;
        private readonly IBlobService _blobService = blobService;

        public async Task<byte[]> Handle(GetMessageImageDto request, CancellationToken cancellationToken)
        {
            var accountId = _accessTokenReader.GetRequiredAccountId();
            
            var message =
                await _messageReadRepository.GetMessageWithImagesAsync(request.MessageId, cancellationToken) ??
                throw new MessageNotFoundException();

            if (accountId != message.SenderId && accountId != message.ReceiverId)
                throw new PermissionDeniedToAccessMessageImage();
            
            var image =
                message.Images.FirstOrDefault(x => x.Id == request.MessageImageId) ??
                throw new MessageImageNotFoundException();

            var stream = _blobService.Read(ContainerName.MesssageImages, image.BlobName);
            return await stream.ToByteArrayAsync();
        }
    }
}
