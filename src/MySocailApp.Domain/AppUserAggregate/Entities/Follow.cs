﻿using MySocailApp.Core;

namespace MySocailApp.Domain.AppUserAggregate.Entities
{
    public class Follow : IRemovable
    {
        public int FollowerId { get; private set; }
        public AppUser Follower { get; } = null!;
        public int FollowedId { get; private set; }
        public AppUser Followed { get; } = null!;
        public DateTime CreatedAt { get; private set; }

        private Follow(int followerId, int followedId)
        {
            FollowerId = followerId;
            FollowedId = followedId;
        }

        public static Follow Create(int followerId, int followedId)
        {
            var r = new Follow(followerId, followedId)
            {
                CreatedAt = DateTime.UtcNow
            };
            return r;
        }


        //IRemovable
        //A follow should only be removed when the user deactivates its account.
        public bool IsRemoved { get; private set; }
        public DateTime? RemovedAt { get; private set; }
        public void Remove()
        {
            IsRemoved = true;
            RemovedAt = DateTime.UtcNow;
        }
        public void Restore()
        {
            IsRemoved = false;
            RemovedAt = null;
        }
    }
}
