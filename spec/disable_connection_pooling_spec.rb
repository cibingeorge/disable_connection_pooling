describe 'disable_connection_pooling' do
  describe 'when Rails 3.2' do
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

      it 'should have been connected until end of the request' do
        script = <<-EOS
          (1..3).map do
            Item.find_by_sql('SHOW PROCESSLIST').to_a
            sleep 1
          end
        EOS

        json = run_script(3201, script)
        p JSON.parse(json)
      end
    end
  end

  describe 'when Rails 4.0' do
    describe 'when disable_connection_pooling = false' do
      it 'should have been connected after request' do
        send_request(4000)
        threads = processlist('rails40_dummy')
        expect(threads.length).to be >= 1
      end
    end

    describe 'when disable_connection_pooling = true' do
      it 'should have been disconnected after request' do
        send_request(4001)
        threads = processlist('rails40_dummy')
        expect(threads.length).to eq(0)
      end
    end
  end
end
