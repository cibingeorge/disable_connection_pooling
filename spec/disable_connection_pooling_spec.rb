describe 'Rails 3.2' do
  describe 'when disable_connection_pooling = false' do
    it 'should have been connected after request' do
      send_request(3200)
      threads = processlist('rails32_dummy')
      expect(threads.length).to be >= 1
    end
  end

  describe 'when disable_connection_pooling = true' do
    it 'should have been disconnected after request' do
      send_request(3201)
      threads = processlist('rails32_dummy')
      expect(threads.length).to eq(0)
    end
  end
end
