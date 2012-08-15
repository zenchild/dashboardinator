=begin
  Copyright 2012 Robert Hart <sasallys@yahoo.co.uk>

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
=end

class Portal < ActiveRecord::Base
  attr_accessible :description, :name, :user_id

  validates :name, :presence => true
  validates :name, :uniqueness => true

  has_many :portlets
  has_many :metrics, :through => :portlets

  belongs_to :user
end
