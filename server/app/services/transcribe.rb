class Transcribe

  def self.convert(path)
    File.delete('out.wav') if File.exist?('out.wav')
    `ffmpeg -i #{path} -acodec pcm_s16le -ac 1 -ar 16000 out.wav`
    async_client = Aws::TranscribeStreamingService::AsyncClient.new(region: 'ap-northeast-1')
    input_stream = Aws::TranscribeStreamingService::EventStreams::AudioStream.new
    output_stream = Aws::TranscribeStreamingService::EventStreams::TranscriptResultStream.new
    audio_file = File.new("out.wav", 'rb')

    output = ""
    output_stream.on_bad_request_exception_event do |exception|
	    input_stream.signal_end_stream
    end
    output_stream.on_transcript_event_event do |event|
      unless event.transcript.results.empty?
        event.transcript.results.each do |result|
         output += result.alternatives.first.transcript unless result.is_partial
        end
      end
    end

  async_resp = async_client.start_stream_transcription(
	  language_code: "en-US",
	  media_encoding: "pcm",
	  media_sample_rate_hertz: 16000,
	  input_event_stream_handler: input_stream,
	  output_event_stream_handler: output_stream
  )

  while !audio_file.eof? do
    input_stream.signal_audio_event_event(audio_chunk: audio_file.read(30000))
    puts "Feeding audio data to Aws service"
    sleep(1)
  end
  sleep(1)
  input_stream.signal_end_stream
  audio_file.close
  resp =  async_resp.wait
  resp =  async_resp.join!
  return output
  end
end
