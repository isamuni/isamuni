class Alloweduser < ApplicationRecord

  def self.from_fb_users groupid, fb_user

    user_uid = fb_user['id']

    if Alloweduser.exists?(user_uid: user_uid)
      user = Alloweduser.where(user_uid: user_uid).first
      user.touch
    else
      user = Alloweduser.new({
        group_uid: groupid,
        user_uid: user_uid,
      })
    end
    
    user
  end

end
