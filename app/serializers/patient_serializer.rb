class PatientSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :name, :photo_url

  def id
    object.uid
  end

  def name
    object.to_s
  end
end
