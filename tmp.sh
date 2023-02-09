source shell_variables_ChIP-nexus.sh

mkdir -p "${coverage_dir}"
ls -1 "${bam_dir}" | grep "\.bam$" > "${bam_file_list}"
mapfile -t bam_files < "${bam_file_list}"
for i in ${!bam_files[@]};
do
  scaling_factor=`samtools idxstats "${bam_dir}${bam_files[${i}]}" | tail -n 18 | head -n 17 | cut -f3 | paste -s -d+ | bc`
  scaling_factor=`echo "scale=6; 1/(${scaling_factor}/1000000)" | bc`
	input_file="${bam_dir}${bam_files[${i}]}"
	bamCoverage --binSize "${bin_size}" --normalizeUsing CPM -p "${CPU}" --bam "${input_file}" -o "${coverage_dir}${bam_files[${i}]}.plus.bw" --scaleFactor "${scaling_factor}" --Offset 1 1 --samFlagExclude 16 --blackListFileName "${genome_dir}${chrom_blacklist}"
	scaling_factor=`echo "${scaling_factor}*-1" | bc`
	bamCoverage --binSize "${bin_size}" --normalizeUsing CPM -p "${CPU}" --bam "${input_file}" -o "${coverage_dir}${bam_files[${i}]}.minus.bw" --scaleFactor "${scaling_factor}" --Offset 1 1 --samFlagInclude 16 --blackListFileName "${genome_dir}${chrom_blacklist}"
done

