      subroutine advance_radau5(
     &     n, fcn, x, y, xend, h, rtol, atol, itol,
     &     jac, ijac, mljac, mujac, mas, imas, mlmas, mumas, work_in,
     &     lwork, iwork_in, liwork, idid)
      external fcn, jac, mas
      integer n, itol, ijac, mljac, mujac, imas, mlmas, mumas, lwork,
     &     iwork_in, liwork, idid
      double precision x, y, xend, h, rtol, atol, work_in
      dimension y(n), rtol(*), atol(*), work_in(9), iwork_in(20)

      double precision, allocatable :: work(:)
      integer, allocatable :: iwork(:)
      integer i, iout

      allocate(iwork(liwork))
      allocate(work(lwork))
      do 10 i = 1, 9
 10      iwork(i) = iwork_in(i)
      do 20 i = 1, 20
 20      work(i) = work_in(i)
      iout = 0
      call radau5(n, fcn, x, y, xend, h, rtol, atol, itol, jac, ijac,
     &     mljac, mujac, mas, imas, mlmas, mumas, solout, iout, work,
     &     lwork, iwork, liwork, rapr, ipar, idid)


C     n -- neq, fcn -- f, x--t, y--u0, xend--tend, h -- first_step,
C     rtol -- rtol, atol--atol, itol--itol, jac--jac, ijac -- ijac,
C     mljac -- ml, mujac -- mu, mas, imas, mlmas, mumas,
C     work(2) -- safety, work(7) -- max_step,
C     iwork(2) -- nsteps,lwork -- lrw, iwork >= 3*neq + 20,
C     liwork -- liw, idid -- istate,
C     dummy inputs: rpar, ipar, solout, iout=0
C     ouput: x, y, h, idid, iwork(14-20)
      return
      end

C     hpl version (iwork and work from Python)
      subroutine advance_radau5_hpl(
     &     n, fcn, x, y, xend, h, rtol, atol, itol,
     &     jac, ijac, mljac, mujac, mas, imas, mlmas, mumas, work,
     &     lwork, iwork, liwork, idid)
      external fcn, jac, mas
      integer n, itol, ijac, mljac, mujac, imas, mlmas, mumas, lwork,
     &     iwork_in, liwork, idid
      double precision x, y, xend, h, rtol, atol, work_in
      dimension y(n), rtol(*), atol(*), work(lwork), iwork(liwork)

      integer iout
      call radau5(n, fcn, x, y, xend, h, rtol, atol, itol, jac, ijac,
     &     mljac, mujac, mas, imas, mlmas, mumas, solout, iout, work,
     &     lwork, iwork, liwork, rapr, ipar, idid)
      return
      end
