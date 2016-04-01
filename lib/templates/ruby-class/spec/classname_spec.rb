describe '%{class_name}' do

  let(:instance) { %{class_name}.new(2,3) }

  describe '.shape_name' do
    context 'with an integer that is in the dictionary' do
      it 'returns shape name' do
        expect(%{class_name}.shape_name(3)).to eq('triangle')
        expect(%{class_name}.shape_name(5)).to eq('pentagon')
      end
    end
    context 'with a value is not in the dictionary' do
      it 'returns unknown' do
        expect(%{class_name}.shape_name(43)).to eq('unknown')
        expect(%{class_name}.shape_name('a')).to eq('unknown')
      end
    end
  end

  describe '#initialize' do
    context 'with a length and width' do
      it 'does not raise an error' do
        expect { %{class_name}.new(2,3) }.to be_a(%{class_name})
      end
      it 'sets length and width' do
        expect(instance.length).to eq(2)
        expect(instance.width).to eq(3)
      end
    end
    context 'with only a length' do
      it 'raises an error' do
        expect { %{class_name}.new(2) }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#area' do
    it 'returns the area' do
      expect(instance.area).to eq(6)
    end
  end
end
