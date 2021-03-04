	module debug

	use mathConstants	

	contains

	Subroutine getProfile(particleVector, particleStartPos, z, profile)
	
		implicit none
		Double Precision, dimension(3), intent(in) :: particleVector, particleStartPos
		Double Precision, intent(in) :: z
		Double Precision, dimension(2), intent(out) :: profile

		profile(1) = (particleVector(1)*z) + particleStartPos(1)
		profile(2) = (particleVector(2)*z) + particleStartPos(2)
	End Subroutine   

	End module debug
