module VersionHelper
  def version_attribute(k)
    if k == 'first_name'
      k = 'name'
    elsif k == 'change_version'
      k = 'version'
    end
    k.titleize
  end

  def version_value_format(val, k = '', both_val = [])
    provinces        = ['birth_province_id', 'province_id']
    referral_sources = ['referral_source_id']
    users            = ['received_by_id', 'followed_up_by_id', 'user_id']
    booleans         = ['has_been_in_orphanage', 'has_been_in_government_care', 'able', 'dependable_income']
    titleizeTexts    = ['gender', 'state', 'family_type', 'roles']
    departments      = ['department_id']
    domain_groups    = ['domain_group_id']

    if titleizeTexts.include?(k)
      if val == both_val[0]
        val  = both_val[0].downcase == both_val[1].downcase ? '' : val.titleize
      else
        val  = val.titleize
      end
    elsif val.class == Date
      val = val.strftime('%d %B, %Y')
    elsif val.class == ActiveSupport::TimeWithZone
      val = val.in_time_zone.strftime('%d %B, %Y %H:%M:%S')
    elsif provinces.include?(k)
      val = Province.find(val).name if val.present?
    elsif referral_sources.include?(k)
      val = ReferralSource.find(val).name if val.present?
    elsif users.include?(k)
      val = User.find(val).name if val.present?
    elsif booleans.include?(k)
      val = human_boolean(val)
    elsif departments.include?(k)
      val = Department.find(val).name if val.present?
    elsif domain_groups.include?(k)
      val = DomainGroup.find(val).name if val.present?
    elsif is_description?(k) && has_html?(val)
      val = strip_tags(val)
    end
    val
  end

  def version_item_type_active?(item_type = '')
    if params[:item_type] || item_type.present?
      'active' if params[:item_type] == item_type
    else
      'active'
    end
  end

  def version_keys_skipable?(k)
    k == 'tokens' || k == 'encrypted_password' || k == 'uid' 
  end

  private

  def is_description?(k)
    k == 'description'
  end

  def has_html?(val)
    strip_tags(val) != val
  end
end