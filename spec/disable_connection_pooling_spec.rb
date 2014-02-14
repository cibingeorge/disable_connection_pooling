describe 'disable_connection_pooling' do
  describe 'when Rails 3.2 / disable_connection_pooling = false'
    it 'should have been connected after request' do
      send_request(3200)

      threads = processlist('rails32_dummy')
      expect(threads.length).to be >= 1
    end
  end
end
