# 10장
## 트랜잭션



### 트랜잭션의 개념
* 하나의 작업을 수행하기 위해 필요한 데이터베이스 연산들을 모아놓은 것
* 작업 수행에 필요한 SQL 문들의 모임
  * 특히, 데이터베이스를 변경하는 INSERT, DELETE, UPDATE 문의 실행을 관리
* 논리적인 작업의 단위
* 장애 발생 시 복구 작업이나 병행 제어 작업을 위한 중요한 단위로 사용됨
* 데이터베이스의 무결성과 일관성을 보장하기 위해 작업 수행에 필요한 연산들을 하나의 트랜잭션으로 제대로 정의하고 관리해야 함

### 트랜잭션의 특성
||정보1|정보2|정보3|...|정보8|당뇨병 여부
|:---:|:---:|:---:|:---:|:---:|:---:|:---:
|1번환자|6|148|72|...|50|1
|2번환자|1|85|66|...|31|0
|3번환자|8|183|64|...|32|1
|...|...|...|...|...|...|...
|768번환자|1|93|70|...|23|0
#### ACID

  * Atomicity - 원자성
    * 트랜잭션의 연산들이 모두 정상적으로 실행되거나 하나도 실행되지 않아야 하는 all-or-nothing 방식을 의미
    * 장애 발생시 실행 연산들을 모두 처리 취소하고 데이터 베이스를 트랜잭션 작업 전 상태로 회귀
    * 원자성 보장을 위해 장애 발생 시 **회복 기능**이 필요

  * Consistency - 일관성
    * 트랜잭션이 성공적으로 수행된 후에도 데이터베이스가 일관성 있는 상태를 유지해야 함을 의미
    * **병행제어 가능**성 필요

  * Isolation - 격리성
    * 수행중인 트랜잭션이 완료될 때까지 다른 트랜잭션들이 중간 연산 결과에 접근할 수 없음을 의미
    * 여러 트랜잭션이 동시에 수행되더라도 마치 순서대로 하나씩 수행되는 것처럼 정확하고 일관된 결과를 얻을수 있도록 제어하는 기능이 필요
    * **병행제어 가능**성 필요

  * Durability - 지속성
    * 트랜잭션이 성공적으로 완료된 후 데이터베이스에 반영한 수행 결과는 영구적이여야 함을 의미
    * 지속성의 보장을 위해서는 장애 발생 시 **회복 기능**이 필요

### 트랜잭션의 주요 연산

* commit
  * 트랜잭션이 성공적으로 수행되었음을 알림 (작업 완료)
  * 데이터 베이스에 트랜잭션 성공 내용들이 반영되며 일관된 상태 유지

* rollback
  * 트랜잭션 수행에 실패하였음을 알림(작업 취소)
  * 트랜잭션 실행 연산들이 취소되며 데이터베이스가 트랜잭션 수행 전의 일관된 상태로 돌아감

### 트랜잭션의 상태

#### 활동 상태 - activation
* 트랜잭션이 수행을 시작하여 현재 수행중인 상태

#### 부분 완료 - partially committed
* 트랜잭션이 마지막 연산의 실행을 끝낸 직후의 상태

#### 완료 상태 - committed
* 트랜잭션이 성공적으로 완료되어commit 연산을 실행한 상태
* 트랜잭션이 수행한 최종 결과를 데이터베이스에 반영하고 데이터베이스가 새로운 일관된 상태가 되면서 트랜잭션이 종료됨

#### 실패 샅태 - failed
* 장애가 발생하여 트랜잭션의 수행이 중단된 상태

#### 철회 상태 - aborted
* 트랜잭션의 수행 실패로 rollback 연산을 실행한 상태
* 지금까지 실행한 트랜잭션의 연산을 모두 취소하고 트랜잭션이 수행되기 전의 데이터베이스 상태로 되돌리면서 트랜잭션이 종료됨
* 철회 상태로 종료된 트랜잭션은 상황에 따라 다시 수행되거나 폐기됨
----------------------------------------

## 장애와 회복

### 장애
* 시스템이 제대로 동작하지 않는 상태

### 장애의 종류

#### 트랜잭션 장애
* 트랜잭션 수행 중 오류가 발생하여 정상적으로 수행을 계속할 수 없는 상태
* 트랜잭션의 논리적 오류, 잘못된 데이터 입력, 시스템 자원의 과다 사용 요구, 처리 대상 데이터의 부재 등

#### 시스템 장애
* 하드웨어의 결함으로 정상적으로 수행을 계속 할 수 없는 상태
* 하드웨어의 이상으로 메인 메모리에 저장된 정보가 손실되거나 교착 상태가 발생한 경우 등

#### 미디어 장애
* 디스크 장치의 결함으로 디스크에 저장된 데이터 베이스의 일부 혹은 전체가 손상된 상태
* 디스크 헤드의 손상이나 고장 등

### 데이터 베이스 저장장치의 종류

#### 휘발성 저장장치(소멸성)
* 장애가 발생하면 저장된 데이터가 손실됨
* 메인 메모리

#### 비휘발성 저장장치(비소멸성)
* 장애가 발생해도 저장된 데이터가 손실되지 않음, 디스크 헤더 손상같은 저장장치 자체에 이상 발생시 손실가능
* 디스크, 자기 테이프, CD/DVD

#### 안정 저장장치
* 비휘발성 저장 장치를 이용해 여러개의 복사본을 만드는 방법으로, 어떤 장애가 발생해도 데이터가 손실되지 않고 데이터를 영구적으로 저장할 수 있음


### 트랜잭션 수행을 위한 데이터 이동 연산
#### 디스크와 메인 메모리간의 연산(input/output)
* 일반적으로 데이터베이스는 비휘발성 저장장치인 디스크에 상주
* 트랜잭션을 통해 데이터를 처리하기 위해서는 디스크에서 데이터를 메인메모리로 가져와 처리 후 결과를 다시 디스크로 보냄
* 연산은 블록단위로 수행됨(디스크 블록, 버퍼 블록)

#### 메인 메모리와 응용프로그램간의 연산(read/write)
* 응용 프로그램에서 트랜잭션 수행 지시시, 메인메모리의 버퍼 블록에 있는 데이터를 프로그램 변수로 가져와 데이터 처리 후 다시 메인메모리 버퍼블록으로 이동

## 회복
### 회복의 개념
* 장애가 발생 시, 데이터베이스를 장애가 발생 전의 일관된 상태로 복구시키는 것
* 트랜잭션의 특성을 보장 및 데이터베이스를 일관된 상태로 유지하기 위해 필수적 기능
* 회복 관리자가 담당(장애 탐지, 복구)

### 회복을 위한 데이터베이스 복사본생성
#### 덤프
* 데이터 베이스 전체를 다른 저장장치에 주기적 복사

#### 로그
* 데이터베이스 변경이 실행될 때마다 이전 값과 이후 값을 별도의 파일에 기록

### log를 이용한 회복연산
#### redo
* 가장 최근에 저장된 데이터베이스 복사본을 가져온 후 로그를 이용해 복사본이 만들어진 이후에 실행된 모든 연산을 재실행하여 장애 발생 직전으로 복구

### undo
* 로그를 이용해 지금까지 실행된 모든 연산을 취소하고 데이터베이스를 원래의 상태로 복구

### 로그 회복기법
#### 즉시갱신 회복기법
* 변경 연산의 결과를 데이터베이스에 즉시 반영
* 장애 발생에 대비하기 위해 데이터 변경에 관한 내용을 로그 파일에 기록
* 장애 발생 시점에 따라 redo, undo 연산을 실행해 데이터베이스를 복구
* 트랜잭션 완료 전 장애 발생 - undo
* 트랜잭션 완료 후 장애 발생 - redo

#### 지연 갱신 회복기법
* 트랜잭션 수행 중에 데이터 변경 연산의 결과를 로그에만 기록해두고, 트랜잭션이 부분 완료된 후에 로그에 기록된 내용을 이용해 데이터베이스에 한번에 반영
* 트랜잭션 수행 중에 장애가 발생하면 로그에 기록된 내용을 버리기만 하면 데이터베이스가 원래 상태를 그대로 유지하게 됨
* redo연산만 사용

#### 검사시점 회복기법
* 로그 기록을 이용하되 일정 시간 간격으로 검사 시점 만듦
* 검사시점에 모든 로그 레코드를 로그 파일에 기록하고 데이터 변경내용을 데이터베이스에 반영 후 검사시점을 표시하는 로그레코드를 로그파일에 기록
* 장애 발생 시 가장 최근 검사 시점 이후의 트랜잭션에만 회복작업 수행
* 비효율성의 문제를 해결

#### 미디어 회복 기법
* 디스크에 발생가능한 장애에 대비한 회복기법
* 덤프 이용(일정주기마다 복사)
* 디스크 발생시 최근 복사해둔 덤프를 이용해 장애 발생이전으로 복구(필요 시 redo 수행)

## 3. 병행제어

### 병행 수행과 병행 제어

#### 병행 수행
* 여러 사용자가 데이터베이스를 동시 공유할 수 있도록 여러개의 트랜잭션을 동시에 수행하는 것을 의미
* 여러 트랜잭션들이 차례로 번갈아 수행되는 인터리빙 방식으로 진행

#### 병행 제어 또는 동시성 제어
* 병행 수행 시 같은 데이터에 접근하여 연산을 실행해도 문제가 발생하지 않고 정확한 수행 결과를 얻을 수 있도록 트랜잭션의 수행을 제어하는 것을 의미
* Lock 정책을 통한 수행
* 문제점(갱신분실, 모순성, 연쇄복귀)

### 병행 수행 시 발생할 수 있는 문제점
#### 갱신 분실
* 하나의 트랜잭션이 수행한 데이터 변경 연산의 결과를 다른 트랜잭션이 덮어써 변경 연산이 무효화 되는 것
* 여러 트랜잭션이 동시에 수행되더라도 갱신 분실 문제가 발생하지 않고 마치 트랜잭션들을 순차적으로 수행한 것과 같은 결과값을 얻을 수 있어야 함

#### 모순성
* 하나의 트랜잭션이 여러개 데이터 변경 연산을 실행할 때 일관성 없는 상태의 데이터베이스에서 데이터를 가져와 연산함으로써 모순된 결과가 발생하는 것
* 여러 트랜잭션이 동시에 수행되더라도 모순성 문제가 발생하지 않고 마치 트랜잭션들을 순차적으로 수행한 것과 같은 결과 값을 얻을 수 있어야 함

#### 연쇄 복귀
* 트랜잭션이 완료되기 전 장애가 발생하여 rollback 연산을 수행하게 되면 장애 발생 전에 이 트랜잭션이 변경한 데이터를 가져가서 변경 연산을 실행한 다른 트랜잭션에도 rollback 연산을 연쇄적으로 실행해야 한다는 것
* 여러 트랜잭션이 동시에 수행되더라도 연쇄 복귀 문제가 발생하지 않고 마치 트랜잭션들을 순차적으로 수행한 것과 같은 결과 값을 얻을 수 있어야 함


### 트랜잭션 스케쥴
* 직렬 스케쥴
* 비직렬 스케쥴(인터리빙 채택)
* 직렬 가능 스케줄(인터리빙 채택)


### 2단계 로킹 규약
* 확장단계
* 축소단계